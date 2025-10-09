import 'package:flutter/material.dart';

import '../const/res/app_color.dart';
import 'app_text.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String? iconPath;
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.title,
    this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: AppColors.black.withAlpha(11),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                if (iconPath != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Image.asset(
                      iconPath!,
                      height: 24,

                    ),
                  ),
                AppText(
                  text: title,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

