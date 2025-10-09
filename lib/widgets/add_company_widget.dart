import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';

import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import '../models/admin/company_model.dart';
import 'app_text.dart';
import 'input_field.dart';
import 'text_action.dart';

Widget buildCompany(BuildContext context, {CompanyModel? existingCompany}) {
  final TextEditingController brandController = TextEditingController(
    text: existingCompany?.name ?? '',
  );
  final companyController = Get.find<CompanyController>();
  final ImagePicker picker = ImagePicker();
  File? pickedImage = existingCompany?.imagePath != null
      ? File(existingCompany!.imagePath!)
      : null;

  return Stack(
    children: [
      StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickImage() async {
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (image != null) {
              setState(() {
                pickedImage = File(image.path);
              });
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: existingCompany == null
                        ? "Add Company"
                        : "Update Company",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    padding: EdgeInsets.all(4),
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
                  controller: brandController,
                  labelShow: false,
                  hintText: "Enter the Company Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: AppIcons.company,
                  label: "Company Name",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 24),
                TextAction(
                  // backgroundColor: AppColors.ceb5757,
                  verticalPadding: 12,
                  text: existingCompany == null ? "Save" : "Update",
                  backgroundColor: Colors.black,
                  circleIcon: Colors.white,
                  onPressed: () {
                    companyController.validateAndSubmitCompany(
                      context: context,
                      brandController: brandController,
                      pickedImage: pickedImage,
                      existingCompany: existingCompany,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
