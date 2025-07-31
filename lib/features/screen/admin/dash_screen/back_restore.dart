import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/res/app_color.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../../../../services/sql_lite_backup_helper.dart';
import '../../../../widgets/build_option.dart';

class BackUp extends StatefulWidget {
  const BackUp({super.key});

  @override
  State<BackUp> createState() => _BackUpState();
}

class _BackUpState extends State<BackUp> {
  final String dbName = 'Munshi_sohail_auto.db';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Backup & Restore",
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.c5669ff),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.c5669ff,
        elevation: 0,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment :CrossAxisAlignment.center,
          children: [
            buildOption(
              title: "Backup All Data",
              onTap: () async {
                await SQLiteBackupHelper.backupDatabase(dbName: dbName);
              },
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            buildOption(
              title: "Restore All Data",
              onTap: () async {
                await SQLiteBackupHelper.restoreDatabase(
                  dbName: dbName,
                  onSuccess: () => Get.snackbar("Success", "Database Restored Successfully",titleText: AppText(text: "Success",)),
                  onError: (e) => Get.snackbar("Error", e),
                );
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
