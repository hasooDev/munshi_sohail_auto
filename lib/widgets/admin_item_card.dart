import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/res/app_icons.dart';
import '../const/routes/app_routes.dart';
import '../features/controller/auth_controller.dart';
import 'Item_card.dart';

class AdminItemCard extends StatelessWidget {
  final authController = Get.put(AuthController());

  AdminItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Company",
        "iconPath": AppIcons.colorCompany,
        "onTap": () => Get.toNamed(AppRoutes.company),
      },
      {
        "title": "Category",
        "iconPath": AppIcons.colorCategory,
        "onTap": () => Get.toNamed(AppRoutes.category),
      },
      {
        "title": "Product",
        "iconPath": AppIcons.colorProduct,
        "onTap": () => Get.toNamed(AppRoutes.product),
      },
      // {
      //   "title": "Customer",
      //   "iconPath": AppIcons.colorCustomer,
      //   "onTap": () => Get.toNamed(AppRoutes.customer),
      // },
      // {
      //   "title": "Sales",
      //   "iconPath": AppIcons.colorSales,
      //   "onTap": () => Get.toNamed(AppRoutes.sales),
      // },
      {
        "title": "Consumer\nData",
        "iconPath": AppIcons.colorClient,
        "onTap": () => Get.toNamed(AppRoutes.clientData),
      },
      {
        "title": "Backup\nData",
        "iconPath": AppIcons.colorBackup,
        "onTap": () => Get.toNamed(AppRoutes.backup),
      },
      {
        "title": "Logout",
        "iconPath": AppIcons.colorLogout,
        "onTap": authController.logout,
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemCard(
          title: item['title'] as String,
          iconPath: item['iconPath'] as String,
          onTap: item['onTap'] as VoidCallback,
        );
      },
    );
  }
}
