import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';

import '../../../../const/res/app_color.dart';
import '../../../../models/admin/company_model.dart';
import '../../../../widgets/add_category_widget.dart';
import '../../../controller/category_controller.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final categoryController = Get.put(CategoryController());
  final companyController = Get.put(CompanyController());
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      categoryController.isLoading.value = true;
      await categoryController.fetchCategories();
      categoryController.isLoading.value = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(title: "Category"),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.c5669ff,
          onPressed: () {
            Get.bottomSheet(
              buildCategory(context),
              backgroundColor: AppColors.white,
            ).then(
              (_) => categoryController.fetchCategories(),
            ); // 🔁 Refresh list
          },
          child: const Icon(Icons.add, color: AppColors.white),
        ),
        body: Obx(() {
          if (categoryController.categoryList.isEmpty) {
            return Center(child: AppText(text: "No Categories Found"));
          }
      
          return ListView.builder(
            itemCount: categoryController.categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryController.categoryList[index];
              final company = companyController.companyList.firstWhere(
                (c) => c.id == category.companyId,
                orElse: () => CompanyModel(id: 0, name: "Unknown", imagePath: ''),
              );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: category.imagePath != null
                          ? Image.file(
                              File(category.imagePath!),
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 55,
                              height: 55,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                    ),
                    title: AppText(
                      text: category.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.c5669ff.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AppText(
                          text: company.name,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.c5669ff,
                        ),
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      icon: const Icon(Icons.more_vert, color: AppColors.black),
                      color: Colors.white,
                      onSelected: (value) {
                        if (value == 'Edit') {
                          Get.bottomSheet(
                            buildCategory(context, existingCategory: category),
                            backgroundColor: AppColors.white,
                          );
                        } else if (value == 'Delete') {
                          categoryController.categoryDeleteDialog(
                            categoryId: category.name,
                            onDelete: () =>
                                categoryController.deleteCategory(category.id!),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => const [
                        PopupMenuItem(
                          value: 'Edit',
                          child: AppText(
                            text: "Update",
                            fontWeight: FontWeight.w700,
                            color: AppColors.c5669ff,
                          ),
                        ),
                        PopupMenuItem(
                          value: 'Delete',
                          child: AppText(
                            text: "Delete",
                            fontWeight: FontWeight.w700,
                            color: AppColors.ceb5757,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
      Obx(() {
          if (!categoryController.isLoading.value) return const SizedBox();
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
      ]
    );
  }
}
