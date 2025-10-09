import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/res/app_color.dart';
import '../../models/admin/product _model.dart';
import '../../services/database_helper.dart';
import '../../widgets/app_text.dart';
import '../../widgets/text_action.dart';

class ProductController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> filteredProductList = <ProductModel>[].obs;
  RxString searchQuery = ''.obs;
  RxBool isLoading=false.obs;


  @override
  void onInit() {
    fetchProducts();
    everAll([searchQuery, productList], (_) => _filterProducts());
    super.onInit();
  }

  Future<void> fetchProducts() async {
    final products = await DatabaseHelper().getProducts();
    productList.assignAll(products);
    _filterProducts();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _filterProducts() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredProductList.assignAll(productList);
    } else {
      filteredProductList.assignAll(
        productList.where((p) => p.name.toLowerCase().contains(query)),
      );
    }
  }

  Future<void> addProduct(ProductModel product) async {
    await DatabaseHelper().insertProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(ProductModel product) async {
    await DatabaseHelper().updateProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(int id) async {
    await DatabaseHelper().deleteProduct(id);
    await fetchProducts();
  }

  Future<void> productDeleteDialog({
    required String? productName,
    required VoidCallback onDelete,
  }) async {
    await Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: "Delete Product",
                color: AppColors.ceb5757,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 10),
              AppText(
                text: "Are you sure you want to delete $productName ?",
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
              const SizedBox(height: 20),
              TextAction(
                text: "Cancel",
                onPressed: () => Get.back(),
                verticalPadding: 8,
                backgroundColor: Colors.transparent,
                textColor: AppColors.c5669ff,
                iconShow: false,
              ),
              TextAction(
                text: "Delete",
                onPressed: () {
                  Get.back();
                    Get.snackbar(
                        "Deleted", // <- title
                        "Company $productName successfully deleted", // <- message
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                        margin: const EdgeInsets.all(12),
                        borderRadius: 8,
                        icon: const Icon(
                          Icons.done_outline,
                          color: Colors.white,
                        ),
                        colorText: Colors.white,
                      );
                  onDelete();
                },
                verticalPadding: 8,
                backgroundColor: AppColors.ceb5757,
                textColor: AppColors.white,
                iconShow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

 /* List<ProductModel> get lowStockProducts => productList.where(
          (product) =>
      product.minStockAlert != null &&
          product.quantityInStock < product.minStockAlert!
  ).toList();*/





  Future<void> validateAndSubmitProduct({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController priceController,
    required TextEditingController quantityController,
    /*required TextEditingController minAlertController,*/
    required String unit,
    File? pickedImage,
    required int? selectedCompanyId,
    required int? selectedCategoryId,
    ProductModel? existingProduct,
  }) async {
    String name = nameController.text.trim();
    if (name.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      Get.snackbar(
        "",
        "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        icon: Icon(Icons.error, color: Colors.white),
        titleText: AppText(text: "Error", color: AppColors.white),
        messageText: AppText(
          text: "Please fill all required fields",
          color: AppColors.white,
        ),
      );
      return;
    }

    final product = ProductModel(
      id: existingProduct?.id,
      name: name,
      imagePath: pickedImage!.path,
      pricePerUnit: double.tryParse(priceController.text) ?? 0,
      quantityInStock: double.tryParse(quantityController.text) ?? 0,
      /*minStockAlert: double.tryParse(minAlertController.text) ?? 0,*/
      unit: unit,
      categoryId: selectedCategoryId,
      companyId: selectedCompanyId,
    );

    if (existingProduct == null) {
      await addProduct(product);
    } else {
      await updateProduct(product);
    }

    nameController.clear();
    priceController.clear();
    quantityController.clear();
    /*minAlertController.clear();*/

    Get.back();

    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      icon: Icon(Icons.done_outline, color: Colors.white),
      titleText: AppText(text: "Success", color: AppColors.white),
      messageText: AppText(
        text: existingProduct == null ? "Product Added Successfully 🎉" : "Product Updated Successfully 🎉",
        color: AppColors.white,
      ),
    );
  }
}
