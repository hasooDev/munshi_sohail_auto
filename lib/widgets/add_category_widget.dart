import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import '../features/controller/category_controller.dart';
import '../models/admin/category_model.dart';
import '../models/admin/company_model.dart';
import 'app_text.dart';
import 'custom_drop_down.dart';
import 'input_field.dart';
import 'text_action.dart';

Widget buildCategory(BuildContext context, {CategoryModel? existingCategory}) {
  final TextEditingController nameController = TextEditingController(
    text: existingCategory?.name ?? '',
  );

  final categoryController = Get.put(CategoryController());
  final ImagePicker picker = ImagePicker();
  File? pickedImage = existingCategory?.imagePath != null
      ? File(existingCategory!.imagePath!)
      : null;

  int? selectedCompanyId = existingCategory?.companyId;


  return StatefulBuilder(
    builder: (context, setState) {
      Future<void> pickImage() async {
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            pickedImage = File(image.path);
          });
        }
      }

      return FutureBuilder<List<CompanyModel>>(
        future: categoryController.getCompanies(),
        builder: (context, snapshot) {
          final companies = snapshot.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: existingCategory == null ? "Add Category" : "Update Category",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(51),
                      image: pickedImage != null
                          ? DecorationImage(
                        image: FileImage(pickedImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: pickedImage == null
                        ? const Image(
                      image: AssetImage(AppIcons.user),
                      height: 14,
                      width: 14,
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                InputField(
                  controller: nameController,
                  labelShow: false,
                  hintText: "Enter Category Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: AppIcons.category, // use a proper icon asset
                  label: "Category Name",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 16),
                CustomDropdown<CompanyModel>(
                  items: companies,
                  selectedItem: companies.firstWhereOrNull((c) => c.id == selectedCompanyId),
                  onChanged: (value) {
                    setState(() => selectedCompanyId = value?.id);
                  },
                  hintText: "Select Company",
                  itemLabelBuilder: (c) => c.name,
                  iconAsset: AppIcons.company,
                ),

                const SizedBox(height: 24),
                TextAction(
                  verticalPadding: 12,
                  backgroundColor: AppColors.black,
                  circleIcon: AppColors.white,
                  text: existingCategory == null ? "Save" : "Update",
                  onPressed: () {
                    categoryController.validateAndSubmitCategory(
                      context: context,
                      nameController: nameController,
                      pickedImage: pickedImage,
                      selectedCompanyId: selectedCompanyId,
                      existingCategory: existingCategory,
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
