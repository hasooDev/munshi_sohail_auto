import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/category_controller.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';
import 'package:sohail_auto/res/app_color.dart';
import 'package:sohail_auto/res/app_icons.dart';
import 'package:sohail_auto/routes/app_routes.dart';
import 'package:sohail_auto/widgets/Item_card.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../../../utility/app_class.dart';
import '../../../widgets/dashboard_card.dart';
import '../../../widgets/dashboard.dart';
import '../../controller/auth_controller.dart';
import '../../controller/product_controller.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final authController = Get.put(AuthController());
  final companyController = Get.put(CompanyController());
  final categoryController = Get.put(CategoryController());
  final productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 18),
                child: AppText(
                  text: 'Dashboard',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              DashBoard(
                items: [
                  GridItem(
                    title: 'Company',
                    number: companyController.companyList.length,
                    iconPath: AppIcons.colorCompany,
                  ),
                  GridItem(
                    title: 'Category',
                    number: categoryController.categoryList.length,
                    iconPath: AppIcons.colorCategory,
                  ),
                  GridItem(
                    title: 'Product',
                    number: productController.productList.length,
                    iconPath: AppIcons.colorProduct,
                  ),
                  GridItem(
                    title: 'Customer',
                    number: 0,
                    iconPath: AppIcons.colorCustomer,
                  ),
                  GridItem
                    (title: 'Sales',
                      number: 0,
                      iconPath: AppIcons.colorSales
                  ),
                  GridItem(
                    title: 'Clients Data',
                    number: 0,
                    iconPath: AppIcons.colorClient,
                  ),
                ],
              ),

              const SizedBox(height: 17),
              ItemCard(
                title: "Company",
                onTap: () {
                  Get.toNamed(AppRoutes.company);
                },
                iconPath: AppIcons.colorCompany,
              ),
              const SizedBox(height: 17),
              ItemCard(
                title: "Category",
                onTap: () {
                  Get.toNamed(AppRoutes.category);
                },
                iconPath: AppIcons.colorCategory,
              ),
              const SizedBox(height: 13),
              ItemCard(
                title: "Product",
                onTap: () {
                  Get.toNamed(AppRoutes.product);
                },
                iconPath: AppIcons.colorProduct,
              ),
              const SizedBox(height: 13),
              ItemCard(
                title: "Customer",
                onTap: () {
                  Get.toNamed(AppRoutes.customer);
                },
                iconPath: AppIcons.colorCustomer,
              ),
              const SizedBox(height: 13),
              ItemCard(
                title: "Sales",
                onTap: () {
                  Get.toNamed(AppRoutes.sales);
                },
                iconPath: AppIcons.colorSales,
              ),
              const SizedBox(height: 13),
              ItemCard(
                title: "Clients Data",
                onTap: () {
                  Get.toNamed(AppRoutes.clientData);
                },
                iconPath: AppIcons.colorClient,
              ),
              const SizedBox(height: 13),
              ItemCard(
                title: "Backup/Restore Data",
                onTap: () => Get.toNamed(AppRoutes.backup),
                iconPath: AppIcons.colorBackup,
              ),
              const SizedBox(height: 13),
              ItemCard(
                title: "Logout",
                onTap: () {
                  authController.logout();
                },
                iconPath: AppIcons.colorLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
