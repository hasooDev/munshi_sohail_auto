import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sohail_auto/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteBackupHelper {
  static const String imagesFolderName = "product_images";

  /// Get DB path
  static Future<String> getDatabasePath(String dbName) async {
    final directory = await getDatabasesPath();
    return "$directory/$dbName";
  }

  /// Get the folder where product images are stored
  static Future<String> getImagesPath() async {
    // ✅ Use documents directory (adjust if you use external storage)
    final directory = await getApplicationDocumentsDirectory();
    return p.join(directory.path, imagesFolderName);
  }

  /// Ensure permission
  static Future<bool> _ensureStoragePermission() async {
    if (await Permission.storage.request().isGranted) return true;
    if (await Permission.manageExternalStorage.request().isGranted) return true;
    return false;
  }

  /// Recursive directory copy
  static Future<void> _copyDirectory(
    Directory source,
    Directory destination,
  ) async {
    if (!await destination.exists()) {
      await destination.create(recursive: true);
    }

    await for (var entity in source.list(recursive: true)) {
      if (entity is File) {
        final relativePath = p.relative(entity.path, from: source.path);
        final newPath = p.join(destination.path, relativePath);
        final newFile = File(newPath);
        if (!await newFile.parent.exists()) {
          await newFile.parent.create(recursive: true);
        }
        await entity.copy(newPath);
      }
    }
  }

  /// Backup DB + images
  static Future<void> backupDatabase({required String dbName}) async {
    try {
      if (!await _ensureStoragePermission()) {
        Get.snackbar("Error", "Storage permission not granted");
        return;
      }

      final dbPath = await getDatabasePath(dbName);
      final dbFile = File(dbPath);
      if (!await dbFile.exists()) {
        Get.snackbar("Error", "Database not found");
        return;
      }

      final imagesPath = await getImagesPath();
      final imagesDir = Directory(imagesPath);

      // Pick folder to save backup
      String? outputDir = await FilePicker.platform.getDirectoryPath();
      if (outputDir == null) {
        Get.snackbar("Cancelled", "No folder selected");
        return;
      }

      // Copy DB
      final backupFile = File(p.join(outputDir, "${dbName}_backup.db"));
      await dbFile.copy(backupFile.path);

      // Copy images recursively
      if (await imagesDir.exists()) {
        final backupImagesDir = Directory(p.join(outputDir, imagesFolderName));
        await _copyDirectory(imagesDir, backupImagesDir);
      }

      Get.snackbar(
        "Success",
        "Backup saved at: $outputDir 🎉",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar("Backup failed", e.toString());
      debugPrint(e.toString());
    }
  }

  /// Restore DB + images
  static Future<void> restoreDatabase({required String dbName}) async {
    try {
      if (!await _ensureStoragePermission()) {
        Get.snackbar("Error", "Storage permission not granted");
        return;
      }

      String? inputDir = await FilePicker.platform.getDirectoryPath();
      if (inputDir == null) {
        Get.snackbar("Cancelled", "No folder selected");
        return;
      }

      final dbBackupFile = File(p.join(inputDir, "${dbName}_backup.db"));
      if (!await dbBackupFile.exists()) {
        Get.snackbar("Error", "Backup database not found");
        return;
      }

      final dbPath = await getDatabasePath(dbName);

      // Close any open DB
      await DatabaseHelper().closeDatabase();

      // Replace DB safely
      final tempPath = "$dbPath.temp";
      await dbBackupFile.copy(tempPath);
      await deleteDatabase(dbPath);
      await File(tempPath).rename(dbPath);

      // Restore images recursively
      final backupImagesDir = Directory(p.join(inputDir, imagesFolderName));
      if (await backupImagesDir.exists()) {
        final imagesPath = await getImagesPath();
        final imagesDir = Directory(imagesPath);
        await _copyDirectory(backupImagesDir, imagesDir);
      }

      Get.snackbar(
        "Success",
        "Database & images restored 🎉",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Restore failed",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
    }
  }
}
