import 'package:flutter/material.dart';

import '../res/app_color.dart';
import 'app_text.dart';
Widget productInfoBox(String title, String value, {Color? cardColor, double titleFontSize = 14}) {
  return Row(

    children: [
      Card(
        color: cardColor ?? AppColors.c5669ff,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: AppText(
            text: title,
            color: AppColors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      AppText(
        text: value,
        fontSize: titleFontSize,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
    ],
  );
}
