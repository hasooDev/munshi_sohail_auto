import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/product_controller.dart';
import 'package:sohail_auto/widgets/add_product_widgets.dart';
import 'package:sohail_auto/widgets/product_info_box.dart';

import '../../../../models/admin/category_model.dart';
import '../../../../models/admin/company_model.dart';
import '../../../../res/app_color.dart';
import '../../../../res/app_images.dart';
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
/*  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      final controller = Get.find<ProductController>();
      if (controller.lowStockProducts.isNotEmpty) {
        showLowStockDialog(controller.lowStockProducts);
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: AppText(
          text: 'Product',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.c5669ff),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
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
          return Center(child: AppText(text: "No Product Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
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

            return Stack(
              children: [
                Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: product.imagePath != null
                              ? Image.file(
                                  File(product.imagePath!),
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppImages.logo,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: AppText(
                            text: product.name,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            productInfoBox("Company",  ": ${company.name }",cardColor:AppColors.c5669ff),
                            productInfoBox("Category", ": ${category.name}",cardColor:AppColors.softRed),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            productInfoBox("Quantity",  ": ${product.quantityInStock }",cardColor:AppColors.c979797,titleFontSize: 14),
                            productInfoBox("Unit", ": ${product.unit}",cardColor:AppColors.teal200,titleFontSize: 14),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            productInfoBox("Price",  ": ${product.pricePerUnit}",cardColor:AppColors.c2b2849,titleFontSize: 17),
                          ],
                        ),


                        /*Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            spacing: 86.0, // space between chips in the row
                            // space between rows
                            children: [
                              Chip(label: Text('Company: ${company.name}')),
                              Chip(label: Text('Category: ${category.name}')),
                              Chip(label: Text('Stock: ${product.quantityInStock}')),
                              Chip(label: Text('Unit: ${product.unit}')),
                              Chip(label: Text('Price: ${product.pricePerUnit}')),
                            ],
                          ),
                        )*/
/*
                           const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                                Expanded(
                                  child: AppText(
                                    text: "Company : ${company.name}",
                                    fontSize: 14,
                                    color: AppColors.black,

                                  ),
                                ),
                            Expanded(
                              child: AppText(
                                text: "Category: ${category.name}",
                                fontSize: 14,
                                color: AppColors.black,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                           const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: "Stock: ${product.quantityInStock}",
                                    fontSize: 14,
                                    color:
                                        product.quantityInStock <
                                            product.minStockAlert
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                  const SizedBox(height: 2),
                                  AppText(
                                    text: "Unit: ${product.unit}",
                                    fontSize: 13,
                                    color: AppColors.c979797,
                                  ),
                                  if (product.quantityInStock <
                                      product.minStockAlert)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: AppText(
                                        text: "Low stock alert!",
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                text:
                                    "Price: ${product.pricePerUnit} ",
                                fontSize: 14,
                                color: AppColors.black,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ),
                ),

                // Popup Menu Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 12),
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
                              onDelete: () =>
                                  productController.deleteProduct(product.id!),
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
                        icon: const Icon(
                          Icons.more_vert,
                          size: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
