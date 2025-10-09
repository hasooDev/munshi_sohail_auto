import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/product_controller.dart';
import 'package:sohail_auto/features/controller/category_controller.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';
import 'package:sohail_auto/const/res/app_color.dart';
import 'package:sohail_auto/models/admin/category_model.dart';
import 'package:sohail_auto/models/user/customer_model.dart';

import '../../../widgets/cart_bottom_sheet.dart';
import '../../controller/cart_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());
  final companyController = Get.put(CompanyController());
  final cartController = Get.put(CartController());

  final RxMap<int, int> cart = <int, int>{}.obs;
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    final Customermodel customer = Get.arguments as Customermodel;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: customer.name,
        showBack: true,
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => searchQuery.value = value.toLowerCase(),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🧱 Product grid
          Expanded(
            child: Obx(() {
              final filteredProducts = productController.filteredProductList
                  .where((p) =>
                  p.name.toLowerCase().contains(searchQuery.value))
                  .toList();

              if (filteredProducts.isEmpty) {
                return const Center(
                  child: AppText(text: "No Products Found"),
                );
              }

              return Stack(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      final category = categoryController.categoryList.firstWhere(
                            (c) => c.id == product.categoryId,
                        orElse: () =>
                            CategoryModel(id: 0, name: "Unknown", companyId: 0),
                      );

                      final isSelected = cart.containsKey(product.id);

                      return GestureDetector(
                        onTap: () {
                          cartController.addToCart(product.id!);
                          setState(() {
                            if (isSelected) {
                              cart.remove(product.id);
                            } else {
                              cart[product.id!] = 1;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.c5669ff
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: product.imagePath.isNotEmpty
                                      ? Image.file(
                                    File(product.imagePath),
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image,
                                        size: 40),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: product.name,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    AppText(
                                      text: "Category: ${category.name}",
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    AppText(
                                      text: "Rs. ${product.pricePerUnit}",
                                      fontSize: 14,
                                      color: AppColors.c5669ff,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  /// 🛒 Bottom "View Cart" bar
                  Obx(() {
                    if (cart.isEmpty) return const SizedBox.shrink();

                    final totalItems =
                    cart.values.fold<int>(0, (sum, q) => sum + q);
                    final totalPrice = cart.entries.fold<double>(
                      0.0,
                          (sum, e) {
                        final product = productController
                            .filteredProductList
                            .firstWhereOrNull((p) => p.id == e.key);
                        return sum +
                            ((product?.pricePerUnit ?? 0) * e.value);
                      },
                    );

                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            CartBottomSheet(
                              cart: cart,
                              customer: customer,
                              productController: productController,
                            ),
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.c5669ff,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "$totalItems item(s)",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text: "View Cart  •  Rs. $totalPrice",
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
