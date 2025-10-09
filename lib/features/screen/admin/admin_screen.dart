import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/category_controller.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';
import 'package:sohail_auto/features/controller/consumer_data_controller.dart';
import 'package:sohail_auto/features/controller/product_controller.dart';
import 'package:sohail_auto/widgets/admin_item_card.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../../../const/res/app_color.dart';
import '../../../const/res/app_icons.dart';
import '../../../utility/app_class.dart';
import '../../../widgets/dashboard.dart';
import '../../controller/auth_controller.dart';

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
  final consumerController = Get.put(ConsumerController());

  @override
  void initState() {
    super.initState();

    // Show loader immediately
    companyController.isLoading.value = true;
    categoryController.isLoading.value = true;
    productController.isLoading.value = true;
    consumerController.isLoading.value = true;

    // Fetch all dashboard data
    Future.wait([
      companyController.fetchCompanies(),
      categoryController.fetchCategories(),
      productController.fetchProducts(),
      consumerController.fetchConsumers(),
    ]).then((_) {
      companyController.isLoading.value = false;
      categoryController.isLoading.value = false;
      productController.isLoading.value = false;
      consumerController.isLoading.value = false;
    });
  }

  bool get isLoading =>
      companyController.isLoading.value ||
      categoryController.isLoading.value ||
      productController.isLoading.value ||
      consumerController.isLoading.value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
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

                Obx(
                  () => DashBoard(
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
                      GridItem(
                        title: 'Sales',
                        number: 0,
                        iconPath: AppIcons.colorSales,
                      ),
                      GridItem(
                        title: 'Consumer Data',
                        number: consumerController.consumerList.length,
                        iconPath: AppIcons.colorClient,
                      ),
                    ],
                  ),
                ),

                AdminItemCard(),
              ],
            ),
          ),
        ),

        // Loader Overlay
        Obx(() {
          if (!isLoading) return const SizedBox();
          return Container(
            color: Colors.black26,
            child: Center(
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: SpinKitFadingCircle(
                  color: Colors.black.withOpacity(0.5),
                  size: 36,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
