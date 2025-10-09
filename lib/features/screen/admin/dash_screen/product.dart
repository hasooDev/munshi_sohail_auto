import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/product_controller.dart';
import 'package:sohail_auto/widgets/add_product_widgets.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';
import 'package:sohail_auto/widgets/product_info_box.dart';

import '../../../../const/res/app_color.dart';
import '../../../../models/admin/category_model.dart';
import '../../../../models/admin/company_model.dart';
import '../../../../widgets/app_text.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/company_controller.dart';

class Product extends StatefulWidget {
  const Product({super.key});
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());
  final companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Products"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.c5669ff,
        onPressed: () {
          Get.bottomSheet(
            buildProductForm(context),
            backgroundColor: AppColors.white,
          ).then((_) => productController.fetchProducts());
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: Obx(() {
        if (productController.productList.isEmpty) {
          return const Center(child: AppText(text: "No Products Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            final product = productController.productList[index];
            final category = categoryController.categoryList.firstWhere(
              (c) => c.id == product.categoryId,
              orElse: () => CategoryModel(id: 0, name: "Unknown", companyId: 0),
            );
            final company = companyController.companyList.firstWhere(
              (c) => c.id == category.companyId,
              orElse: () => CompanyModel(id: 0, name: "Unknown", imagePath: ''),
            );

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Background white card
                    Container(
                      color: AppColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image with overlay
                          Stack(
                            children: [
                              Image.file(
                                File(product.imagePath),
                                height: 190,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                height: 190,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              // Price tag overlay
                              Positioned(
                                bottom: 12,
                                right: 12,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 6,
                                      sigmaY: 6,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),
                                      color: Colors.black.withOpacity(0.35),
                                      child: AppText(
                                        text: "Rs. ${product.pricePerUnit}",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Details
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Container(
                               margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Name
                                  AppText(
                                    text: product.name,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.black,
                                  ),

                                  const SizedBox(height: 14),

                                  // 🔹 Info in grid-like Wrap layout
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      productInfoBox(
                                        "Company",
                                        company.name,
                                        cardColor: AppColors.c5669ff,
                                      ),
                                      productInfoBox(
                                        "Category",
                                        category.name,
                                        cardColor: AppColors.softRed,
                                      ),
                                      productInfoBox(
                                        "Stock",
                                        product.quantityInStock.toString(),
                                        cardColor: AppColors.c979797,
                                      ),
                                      productInfoBox(
                                        "Unit",
                                        product.unit,
                                        cardColor: AppColors.teal200,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Popup menu top-right
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: PopupMenuButton<String>(
                          color: AppColors.white,
                          onSelected: (value) {
                            if (value == 'edit') {
                              Get.bottomSheet(
                                buildProductForm(
                                  context,
                                  existingProduct: product,
                                ),
                                backgroundColor: AppColors.white,
                              ).then((_) => productController.fetchProducts());
                            } else if (value == 'delete') {
                              productController.productDeleteDialog(
                                productName: product.name,
                                onDelete: () => productController.deleteProduct(
                                  product.id!,
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: AppText(
                                text: "Update",
                                fontWeight: FontWeight.w600,
                                color: AppColors.c5669ff,
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: AppText(
                                text: "Delete",
                                fontWeight: FontWeight.w600,
                                color: AppColors.softRed,
                              ),
                            ),
                          ],
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.more_vert,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
