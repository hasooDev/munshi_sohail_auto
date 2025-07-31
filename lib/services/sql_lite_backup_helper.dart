import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteBackupHelper {
  /*Get your database file path*/
  static Future<String> getDatabasePath(String dbName) async {
    final directory = await getDatabasesPath();
    return "$directory/$dbName";
  }

  /*Backup database to Downloads folder*/
  static Future<void> backupDatabase({required String dbName}) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception("Storage permission not granted");
    }

    final dbPath = await getDatabasePath(dbName);
    final backupDir = Directory('/storage/emulated/0/Download');
    final backupFile = File('${backupDir.path}/$dbName.backup');

    await File(dbPath).copy(backupFile.path);
    debugPrint("Database backup saved ${backupFile.path}");
  }

  /*Restore database using File Picker*/
  static Future<void> restoreDatabase({
    required String dbName,
    required VoidCallback onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null && result.files.single.path != null) {
        final selectedFile = File(result.files.single.path!);
        final dbPath = await getDatabasePath(dbName);


        await selectedFile.copy(dbPath);

        onSuccess();
      } else {
        onError("No file selected");
      }
    } catch (e) {
      onError("Restore failed: $e");
    }
  }
}
