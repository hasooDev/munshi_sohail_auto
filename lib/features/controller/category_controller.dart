import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/admin/category_model.dart';
import '../../models/admin/company_model.dart';
import '../../res/app_color.dart';
import '../../services/database_helper.dart';
import '../../widgets/app_text.dart';
import '../../widgets/text_action.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredCategoryList = <CategoryModel>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    fetchCategories();
    everAll([searchQuery, categoryList], (_) => _filterCategories());
    super.onInit();
  }

  Future<void> fetchCategories() async {
    final categories = await DatabaseHelper().getCategories();
    categoryList.assignAll(categories);
    _filterCategories();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _filterCategories() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredCategoryList.assignAll(categoryList);
    } else {
      filteredCategoryList.assignAll(
        categoryList.where(
              (c) => c.name.toLowerCase().contains(query),
        ),
      );
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    await DatabaseHelper().insertCategory(category);
    await fetchCategories();
  }

  Future<void> updateCategory(CategoryModel category) async {
    await DatabaseHelper().updateCategory(category);
    await fetchCategories();
  }

  Future<void> deleteCategory(int id) async {
    await DatabaseHelper().deleteCategory(id);
    await fetchCategories();
  }

  Future<List<CompanyModel>> getCompanies() async {
    return await DatabaseHelper().getCompanies();
  }

  Future<void> categoryDeleteDialog({
    required String? categoryId,
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
                text: "Delete Category",
                color: AppColors.ceb5757,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 10),
              AppText(
                text: "Are you sure you want to delete $categoryId?",
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
              const SizedBox(height: 20),
              TextAction(
                fontSize: 18,
                text: "Cancel",
                onPressed: () => Get.back(),
                verticalPadding: 8,
                backgroundColor: Colors.transparent,
                textColor: AppColors.c5669ff,
                iconShow: false,
              ),
              TextAction(
                fontSize: 18,
                text: "Delete",
                onPressed: () {
                  Get.back();
                  onDelete();
                },
                verticalPadding: 8,
                textColor: AppColors.white,
                iconShow: false,
                backgroundColor: AppColors.ceb5757,
              ),
            ],
          ),
        ),
      ),
    );
  }
// Validate and Submit Button Work
  Future<void> validateAndSubmitCategory({
    required BuildContext context,
    required TextEditingController nameController,
    File? pickedImage,
    required int? selectedCompanyId,
    CategoryModel? existingCategory,
  }) async {
    String name = nameController.text.trim();
    if (name.isEmpty || selectedCompanyId == null) {
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
          text: name.isEmpty
              ? "Category name is required"
              : "Please select a company",
          color: AppColors.white,
        ),
      );
      return;
    }

    final category = CategoryModel(
      id: existingCategory?.id,
      name: name,
      imagePath: pickedImage?.path,
      companyId: selectedCompanyId,
    );

    if (existingCategory == null) {
      await addCategory(category);
    } else {
      await updateCategory(category);
    }

    nameController.clear();
    Get.back();
    Get.snackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      icon: Icon(Icons.check_circle_outline, color: Colors.white),
      titleText: AppText(
        text: "Success",
        color: AppColors.white,
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
      messageText: AppText(
        text: existingCategory == null
            ? "Category Added Successfully 🎉"
            : "Category Updated 🎯",
        color: AppColors.white,
      ),
      "",
      "",
    );
  }
}
