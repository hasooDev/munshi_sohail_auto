import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/res/app_color.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack; // 👈 control visibility of back button

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true, // default true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false
      ,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      scrolledUnderElevation: 0,
      title: AppText(
        text: title,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      leading: showBack
          ? Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, size: 23, color: AppColors.black),
        ),
      )
          : null, // 👈 hides back button
      backgroundColor: AppColors.white,
      elevation: 0,

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
