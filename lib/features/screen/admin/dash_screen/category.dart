import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';
import 'package:sohail_auto/res/app_color.dart';
import 'package:sohail_auto/widgets/app_text.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: AppText(
          text: 'Category',
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
              padding: const EdgeInsets.only(top: 0,
              left: 12,right: 12,bottom: 12),
              child: Card(
                color: AppColors.white,
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  splashColor: Colors.transparent,
                  leading: category.imagePath != null
                      ? CircleAvatar(
                          radius: 34,
                          backgroundImage: FileImage(File(category.imagePath!)),
                        )
                      : const CircleAvatar(child: Icon(Icons.image)),
                  title: AppText(
                    text: category.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: 'Company : ',
                      style: TextStyle(
                        color: AppColors.softRed,
                        fontFamily: "Lexend",
                        fontSize: 14,
                        fontWeight: FontWeight.w800
                      ),
                      children: [
                        TextSpan(
                          text: company.name,
                          style: TextStyle(
                            fontFamily: "Lexend",
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ],
                    ),
                  ),
              /*Pop Up item :*/
                  trailing: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: AppColors.black),
                      color: AppColors.white,
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
              ),
            );

          },
        );
      }),
    );
  }
}
