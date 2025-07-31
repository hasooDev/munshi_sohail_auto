import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/controller/category_controller.dart';
import '../../features/controller/company_controller.dart';
import '../../features/controller/product_controller.dart';
import '../../res/app_color.dart';
import '../../res/app_icons.dart';
import '../models/admin/category_model.dart';
import '../models/admin/company_model.dart' show CompanyModel;
import '../models/admin/product _model.dart';
import 'app_text.dart';
import 'custom_drop_down.dart';
import 'input_field.dart';
import 'text_action.dart';

Widget buildProductForm(BuildContext context, {ProductModel? existingProduct}) {
  final productController = Get.find<ProductController>();
  final companyController = Get.find<CompanyController>();
  final categoryController = Get.find<CategoryController>();

  final nameController = TextEditingController(text: existingProduct?.name ?? '');
  final priceController = TextEditingController(text: existingProduct?.pricePerUnit.toString() ?? '');
  final quantityController = TextEditingController(text: existingProduct?.quantityInStock.toString() ?? '');
  /*final minAlertController = TextEditingController(text: existingProduct?.minStockAlert?.toString() ?? '');*/
  final companies = companyController.companyList;
  final categories = categoryController.categoryList;

  final ImagePicker picker = ImagePicker();
  File? pickedImage = existingProduct?.imagePath != null ? File(existingProduct!.imagePath!) : null;

  String selectedUnit = existingProduct?.unit ?? 'liter';
  int? selectedCompanyId = existingProduct?.companyId;
  int? selectedCategoryId = existingProduct?.categoryId;

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

      /* MAIN Code start */
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AppText(
                text: existingProduct == null ? "Add Product" : "Update Product",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: pickedImage != null
                      ? DecorationImage(image: FileImage(pickedImage!), fit: BoxFit.cover)
                      : null,

                ),
                child: pickedImage == null
                    ? const Image(
                  image: AssetImage(AppIcons.user),
                  height: 20,
                  width: 20,
                )
                    : null,
              ),
            ),

            const SizedBox(height: 20),
            InputField(
              hintColor: AppColors.black,
              controller: nameController,
              hintText: "Product Name",
              label: "Name",
              prefixIcon: AppIcons.product,
              fillColor: AppColors.black.withAlpha(12),
              labelColor: AppColors.black,
              prefixColor: Colors.black,
            ),
            const SizedBox(height: 16),
            InputField(
              hintColor: AppColors.black,
              controller: priceController,
              hintText: "Price per Unit",
              label: "Price",
              keyboardType: TextInputType.number,
              prefixIcon: AppIcons.rupee,
              fillColor: AppColors.black.withAlpha(12),
              labelColor: AppColors.black,
              prefixColor: Colors.black,
            ),
            const SizedBox(height: 16),
            InputField(
              hintColor: AppColors.black,
              controller: quantityController,
              hintText: "Initial Quantity",
              label: "Quantity",
              keyboardType: TextInputType.number,
              prefixIcon: AppIcons.quantity,
              fillColor: AppColors.black.withAlpha(12),
              labelColor: AppColors.black,
              prefixColor: Colors.black,
            ),
            /*const SizedBox(height: 16),
            InputField(
              hintColor: AppColors.black,
              controller: minAlertController,
              hintText: "Min Stock Alert",
              label: "Stock Alert",
              keyboardType: TextInputType.number,
              prefixIcon: AppIcons.alert,
              fillColor: AppColors.black.withAlpha(12),
              labelColor: AppColors.black,
prefixColor: AppColors.black,
            ),*/
            const SizedBox(height: 16),
            CustomDropdown<String>(
              items: ['liter', 'piece'],
              selectedItem: selectedUnit,
              onChanged: (value) {
                setState(() => selectedUnit = value ?? 'liter'); // fallback if null
              },
              hintText: "Select Unit",
              itemLabelBuilder: (unit) => unit,
              iconAsset: AppIcons.unit,
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

            const SizedBox(height: 16),
            CustomDropdown<CategoryModel>(
              items: categories,
              selectedItem: categories.firstWhereOrNull((c) => c.id == selectedCategoryId),
              onChanged: (value) {
                setState(() => selectedCategoryId = value?.id);
              },
              hintText: "Select Category",
              itemLabelBuilder: (c) => c.name,
              iconAsset: AppIcons.category,
            ),


            const SizedBox(height: 24),
            TextAction(
              text: existingProduct == null ? "Save" : "Update",
              onPressed: () {
                productController.validateAndSubmitProduct(
                  context: context,
                  nameController: nameController,
                  priceController: priceController,
                  quantityController: quantityController,
                 /* minAlertController: minAlertController,*/
                  pickedImage: pickedImage,
                  unit: selectedUnit,
                  selectedCompanyId: selectedCompanyId,
                  selectedCategoryId: selectedCategoryId,
                  existingProduct: existingProduct,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
