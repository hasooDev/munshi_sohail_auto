import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/const/routes/app_routes.dart';
import 'package:sohail_auto/features/controller/home_controller.dart';
import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import '../const/res/app_images.dart';
import 'app_text.dart';

Widget homeHeader() {
  final homeController = Get.put(HomeController());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: "Hi ! Sohail Auto",
          color: AppColors.black,
          fontSize: 23,
          fontWeight: FontWeight.w800,
        ),

        /// Popup Menu with Avatar
        PopupMenuButton<String>(
          color: Colors.white,
          onSelected: (value) {
            if (value == "company") {
              Get.toNamed(AppRoutes.customerList);
            } else if (value == "logout") {
              homeController.logout();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "company",
              child: Row(
                children: [
                  Image.asset(
                    AppIcons.colorCustomer,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  AppText(text: "Customer"),
                ],
              ),
            ),
            PopupMenuItem(
              value: "logout",
              child: Row(
                children: [
                  Image.asset(AppIcons.logout, height: 20, width: 20),
                  const SizedBox(width: 10),
                  AppText(text: "Logout"),
                ],
              ),
            ),
          ],
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppImages.maker),
          ),
        )

      ],
    ),
  );
}
