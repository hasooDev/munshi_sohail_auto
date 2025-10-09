
import 'package:flutter/material.dart';

import '../const/res/app_color.dart';
import 'app_text.dart';

Widget productInfoBox(
  String title,
  String value, {
  Color? cardColor,
  double titleFontSize = 14,
  double valueFontSize = 14,
  Color? valueColor,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.08),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // ignore: deprecated_member_use
                (cardColor ?? AppColors.c5669ff).withOpacity(0.9),
                // ignore: deprecated_member_use
                (cardColor ?? AppColors.c5669ff).withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: AppText(
            text: title,
            color: AppColors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(width: 6),

        // Value
        AppText(
          text: value,
          fontSize: valueFontSize,
          fontWeight: FontWeight.w700,
          color: valueColor ?? AppColors.black,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
