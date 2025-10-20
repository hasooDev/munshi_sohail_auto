import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sohail_auto/services/database_helper.dart';

import '../features/controller/category_controller.dart';
import '../features/controller/company_controller.dart';
import '../features/controller/product_controller.dart';

class SQLiteBackupHelper {
  // Folder names for image storage used in your app
  static const String companyImagesFolder = "company_images";
  static const String categoryImagesFolder = "category_images";
  static const String productImagesFolder = "product_images";
  static const String serviceImagesFolder = "service_images";

  /// ✅ Get database path
  static Future<String> getDatabasePath(String dbName) async {
    final directory = await getDatabasesPath();
    return "$directory/$dbName";
  }

  /// ✅ Get app documents directory
  static Future<String> getAppDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// ✅ Ensure storage permission
  static Future<bool> _ensureStoragePermission() async {
    if (await Permission.storage.request().isGranted) return true;
    if (await Permission.manageExternalStorage.request().isGranted) return true;
    return false;
  }

  /// ✅ Copy directory recursively (used for restoring images)
  static Future<void> _copyDirectory(Directory source, Directory destination) async {
    if (!await destination.exists()) {
      await destination.create(recursive: true);
    }
    await for (var entity in source.list(recursive: true)) {
      if (entity is File) {
        final relativePath = p.relative(entity.path, from: source.path);
        final newPath = p.join(destination.path, relativePath);
        final newFile = File(newPath);
        await newFile.parent.create(recursive: true);
        await entity.copy(newPath);
      }
    }
  }

  /// ✅ ZIP multiple image directories
  static Future<String> _zipAllImages(List<String> imageDirs, String outputDir) async {
    final zipPath = p.join(outputDir, "all_images.zip");
    final encoder = ZipFileEncoder();
    encoder.create(zipPath);

    for (final dirPath in imageDirs) {
      final dir = Directory(dirPath);
      if (await dir.exists()) {
        encoder.addDirectory(dir);
      }
    }

    encoder.close();
    return zipPath;
  }

  /// ✅ Unzip all images into the correct directories
  static Future<void> _unzipImages(String zipPath, String outputDir) async {
    final bytes = File(zipPath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final filePath = p.join(outputDir, file.name);
      if (file.isFile) {
        final f = File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(file.content);
      }
    }
  }

  // -----------------------------------------------------------------------------
  // 🔹 BACKUP (Database + All Images)
  // -----------------------------------------------------------------------------
  static Future<void> backupDatabase({required String dbName}) async {
    try {
      if (!await _ensureStoragePermission()) {
        Get.snackbar("Permission Denied", "Storage permission not granted");
        return;
      }

      final dbPath = await getDatabasePath(dbName);
      final dbFile = File(dbPath);
      if (!await dbFile.exists()) {
        Get.snackbar("Error", "Database not found");
        return;
      }

      final appPath = await getAppDocumentsPath();

      // Image folders used throughout your app
      final imageFolders = [
        p.join(appPath, companyImagesFolder),
        p.join(appPath, categoryImagesFolder),
        p.join(appPath, productImagesFolder),
        p.join(appPath, serviceImagesFolder),
      ];

      // Ask user to select backup destination
      String? outputDir = await FilePicker.platform.getDirectoryPath();
      if (outputDir == null) {
        Get.snackbar("Cancelled", "Backup folder not selected");
        return;
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final backupDir = Directory(p.join(outputDir, "Backup_$timestamp"));
      await backupDir.create(recursive: true);

      // Copy DB
      final backupFile = File(p.join(backupDir.path, "${dbName}_backup.db"));
      await dbFile.copy(backupFile.path);

      // ZIP all image folders
      await _zipAllImages(imageFolders, backupDir.path);

      Get.snackbar(
        "✅ Backup Complete",
        "Backup successfully saved at:\n${backupDir.path}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        "❌ Backup Failed",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      debugPrint("Backup error: $e");
    }
  }

  // -----------------------------------------------------------------------------
  // 🔹 RESTORE (Database + All Images)
  // -----------------------------------------------------------------------------
  static Future<void> restoreDatabase({required String dbName}) async {
    try {
      if (!await _ensureStoragePermission()) {
        Get.snackbar("Permission Denied", "Storage permission not granted");
        return;
      }

      String? inputDir = await FilePicker.platform.getDirectoryPath();
      if (inputDir == null) {
        Get.snackbar("Cancelled", "Restore folder not selected");
        return;
      }

      // Look for backup DB file
      final dbBackupFile = Directory(inputDir)
          .listSync()
          .whereType<File>()
          .firstWhere(
            (f) => f.path.endsWith("_backup.db"),
        orElse: () => throw Exception("Backup database file not found."),
      );

      final dbPath = await getDatabasePath(dbName);
      await DatabaseHelper().closeDatabase();

      // Safely replace DB
      final tempPath = "$dbPath.temp";
      await dbBackupFile.copy(tempPath);
      await deleteDatabase(dbPath);
      await File(tempPath).rename(dbPath);

      // Restore all image folders from zip
      final zipFile = File(p.join(inputDir, "all_images.zip"));
      if (await zipFile.exists()) {
        final appPath = await getAppDocumentsPath();
        await _unzipImages(zipFile.path, appPath);
      }
      try {
        final categoryController = Get.find<CategoryController>();
        final productController = Get.find<ProductController>();
        final companyController = Get.find<CompanyController>();

        await categoryController.fetchCategories();
        await productController.fetchProducts();
        await companyController.fetchCompanies();

        debugPrint("Controllers reloaded successfully after restore ✅");
      } catch (e) {
        debugPrint("Controller reload error: $e");
      }
      Get.snackbar(
        "✅ Restore Complete",
        "Database & all images restored successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        "❌ Restore Failed",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      debugPrint("Restore error: $e");
    }
  }
}
