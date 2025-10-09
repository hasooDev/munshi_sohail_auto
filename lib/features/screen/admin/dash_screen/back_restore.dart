// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../const/res/app_color.dart';
// import '../../../../services/sql_lite_backup_helper.dart';
// import '../../../../utility/request_permission_handler.dart';
// import '../../../../widgets/build_option.dart';
// import '../../../../widgets/custom_app_bar.dart';

// class BackUp extends StatefulWidget {
//   const BackUp({super.key});

//   @override
//   State<BackUp> createState() => _BackUpState();
// }

// class _BackUpState extends State<BackUp> {
//   final String dbName = 'Munshi_sohail_auto.db';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "BackUp & Restore"),
//       backgroundColor: AppColors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment :CrossAxisAlignment.center,
//           children: [

//             buildOption(
//               title: "Backup All Data",
//               onTap: () async {
//                 await requestStoragePermission();
//                 await SQLiteBackupHelper.backupDatabase(dbName: dbName);
//               },
//               color: Colors.green,
//             ),
//             const SizedBox(height: 20),
//             buildOption(
//               title: "Restore All Data",
//               onTap: () async {
//                 try {
//                   await requestStoragePermission();
//                   await SQLiteBackupHelper.restoreDatabase(dbName: dbName );
//                   Get.snackbar("Success", "Database Backup Completed");
//                 } catch (e) {
//                   Get.snackbar("Error", e.toString());
//                 }
//               },

//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:sohail_auto/widgets/app_text.dart';
// //
// // import '../../../../const/res/app_color.dart';
// // import '../../../../services/sql_lite_backup_helper.dart';
// // import '../../../../utility/request_permission_handler.dart';
// // import '../../../../widgets/build_option.dart';
// // import '../../../../widgets/custom_app_bar.dart';
// //
// // class BackUp extends StatefulWidget {
// //   const BackUp({super.key});
// //
// //   @override
// //   State<BackUp> createState() => _BackUpState();
// // }
// //
// // class _BackUpState extends State<BackUp> {
// //   final String dbName = 'Munshi_sohail_auto.db';
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: const CustomAppBar(title: "BackUp & Restore"),
// //       backgroundColor: AppColors.white,
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // 🏷 Title
// //             AppText(
// //               text: "Backup & Restore",
// //               fontSize: 24,
// //               fontWeight: FontWeight.bold,
// //               color: AppColors.black,
// //             ),
// //
// //             const SizedBox(height: 8),
// //
// //             // 📖 Description
// //             AppText(
// //               text:
// //               "Keep your data safe by creating backups regularly. "
// //                   "You can restore your data anytime if something goes wrong.",
// //               fontSize: 14,
// //               color: AppColors.c979797,
// //             ),
// //
// //             const SizedBox(height: 30),
// //
// //             // ✅ Backup Option
// //             buildOption(
// //               title: "Backup All Data",
// //               onTap: () async {
// //                 try {
// //                   await requestStoragePermission();
// //                   await SQLiteBackupHelper.backupDatabase(dbName: dbName);
// //                   Get.snackbar("Success", "Database Backup Completed");
// //                 } catch (e) {
// //                   Get.snackbar("Error", e.toString());
// //                 }
// //               },
// //               color: Colors.green,
// //             ),
// //
// //             const SizedBox(height: 20),
// //
// //             // ♻️ Restore Option
// //             buildOption(
// //               title: "Restore All Data",
// //               onTap: () async {
// //                 try {
// //                   await requestStoragePermission();
// //                   await SQLiteBackupHelper.backupDatabase(dbName: dbName);
// //                   Get.snackbar("Success", "Database Restored Successfully");
// //                 } catch (e) {
// //                   Get.snackbar("Error", e.toString());
// //                 }
// //               },
// //               color: Colors.blue,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../../../../const/res/app_color.dart';
import '../../../../services/sql_lite_backup_helper.dart';
import '../../../../utility/request_permission_handler.dart';
import '../../../../widgets/build_option.dart';
import '../../../../widgets/custom_app_bar.dart';

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
      appBar: const CustomAppBar(title: "Backup & Restore"),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷 Big Title
            AppText(
              text: "Keep Your Data Safe",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),

            const SizedBox(height: 8),

            // 📖 Description
            AppText(
              text:
                  "Backup allows you to save a copy of all your app data securely. "
                  "If something goes wrong, you can easily restore everything back "
                  "with just one tap.",
              fontSize: 15,
              color: AppColors.c979797,
            ),

            const SizedBox(height: 30),

            // ✅ Backup Option
            buildOption(
              title: "📦 Backup All Data",
              onTap: () async {
                await requestStoragePermission();
                await SQLiteBackupHelper.backupDatabase(dbName: dbName);
              },
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            // ♻️ Restore Option
            buildOption(
              title: "♻️ Restore All Data",
              onTap: () async {
                await requestStoragePermission();
                await SQLiteBackupHelper.restoreDatabase(dbName: dbName);
              },
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            // ℹ️ Extra Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.black54),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppText(
                      text:
                          "Tip: It’s recommended to take regular backups, especially before clear storage the app.",
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
