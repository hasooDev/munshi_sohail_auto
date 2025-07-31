import 'package:flutter/material.dart';
import 'package:sohail_auto/widgets/text_action.dart';

Widget buildOption({
  required String title,
  required VoidCallback onTap,
  required Color color,
}) {
  return TextAction(
    iconShow:false,
    text: title,
    onPressed: onTap,
    backgroundColor: color,
    fontSize: 16,
    verticalPadding: 14,
    textColor: Colors.white,
  );
}