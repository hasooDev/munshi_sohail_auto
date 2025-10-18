
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/munshi_sohail_auto.dart';
import 'package:sohail_auto/services/database_helper.dart';
import 'package:sohail_auto/utility/request_permission_handler.dart';
import 'package:sohail_auto/utility/storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();
  final storageService = await StorageService().init();
  Get.put(storageService);
  /*Status Bar Colors*/
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  /* Future Task */
  Future.microtask(() async {
    try {
      // This will trigger _initDB() internally
      await DatabaseHelper().database;
      debugPrint("✅ SQLite Database initialized in background");
    } catch (e, s) {
      debugPrint("❌ Error during background init: $e");
      debugPrintStack(stackTrace: s);
    }
  });
  runApp(MunshiSohailAuto());


}
