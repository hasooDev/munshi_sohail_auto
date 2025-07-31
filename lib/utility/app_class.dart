import 'package:flutter/cupertino.dart';

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