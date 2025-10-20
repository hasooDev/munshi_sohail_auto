import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/sql_lite_backup_helper.dart';

class GridItem {
  final String title;
  final int number;
  final String iconPath;

  GridItem({
    required this.title,
    required this.number,
    required this.iconPath,
  });
}

/*CLASS OF DASHBOARD ITEM*/
class DashBoardItem {
  final String title;

  final String iconPath;
  final VoidCallback? onTap;

  DashBoardItem({
    required this.title,

    required this.iconPath,
    required this.onTap
  });
}

// qty controls
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 6),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       IconButton(
//         onPressed: () {
//           // TODO: decrease quantity for this customer
//         },
//         icon: const Icon(Icons.remove_circle,
//             color: Colors.red),
//       ),
//       const AppText(
//         text: "0", // TODO: bind to selected quantity
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//       ),
//       IconButton(
//         onPressed: () {
//           // TODO: increase quantity for this customer
//         },
//         icon: const Icon(Icons.add_circle,
//             color: Colors.green),
//       ),
//     ],
//   ),
// ),


// Future<void> backupToSupabase() async {
//   final dbData = await SQLiteBackupHelper.exportToJson(); // You create this
//   final supabase = Supabase.instance.client;
//   await supabase.from('backups').insert({
//     'user_id': supabase.auth.currentUser?.id,
//     'db_data': jsonEncode(dbData),
//   });
// }
