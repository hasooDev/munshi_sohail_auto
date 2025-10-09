import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sohail_auto/features/controller/consumer_data_controller.dart';
import 'package:sohail_auto/models/admin/consumer_data_model.dart';

import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import 'app_text.dart';
import 'input_field.dart';
import 'text_action.dart';

Widget buildConsumer(BuildContext context, {ConsumerModel? existingConsumer}) {
  final TextEditingController nameController =
      TextEditingController(text: existingConsumer?.name ?? '');
  final TextEditingController phoneController =
      TextEditingController(text: existingConsumer?.phone ?? '');
  final TextEditingController shopNameController =
      TextEditingController(text: existingConsumer?.shopName ?? '');
  final TextEditingController totalPriceController =
      TextEditingController(text: existingConsumer?.totalPrice.toString() ?? '');
  final TextEditingController paidAmountController =
      TextEditingController(text: existingConsumer?.paidAmount.toString() ?? '');
  final TextEditingController dateController = TextEditingController(
    text: existingConsumer?.date ?? DateTime.now().toIso8601String(),
  );

  final consumerController = Get.find<ConsumerController>();
  final ImagePicker picker = ImagePicker();
  File? pickedImage = existingConsumer?.billImagePath != null
      ? File(existingConsumer!.billImagePath!)
      : null;

  return Stack(
    children: [
      StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickImage() async {
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                pickedImage = File(image.path);
              });
            }
          }

          Future<void> pickDate() async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                dateController.text = picked.toString();
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
                    text: existingConsumer == null
                        ? "Add Consumer"
                        : "Update Consumer",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Profile / Bill Image
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

                // Name
                InputField(
                  controller: nameController,
                  labelShow: false,
                  hintText: "Enter Consumer Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: AppIcons.user,
                  label: "Name",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 16),

                // Phone
                InputField(
                  controller: phoneController,
                  labelShow: false,
                  hintText: "Enter Phone Number",
                  keyboardType: TextInputType.phone,
                  prefixIcon: AppIcons.call,
                  label: "Phone",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 16),

                // Shop Name
                InputField(
                  controller: shopNameController,
                  labelShow: false,
                  hintText: "Enter Shop Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: AppIcons.shop,
                  label: "Shop Name",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 16),

                // Total Price
                InputField(
                  controller: totalPriceController,
                  labelShow: false,
                  hintText: "Enter Total Price",
                  keyboardType: TextInputType.number,
                  prefixIcon: AppIcons.rupee,
                  label: "Total Price",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 16),

                // Paid Amount
                InputField(
                  controller: paidAmountController,
                  labelShow: false,
                  hintText: "Enter Paid Amount",
                  keyboardType: TextInputType.number,
                  prefixIcon: AppIcons.rupee,
                  label: "Paid Amount",
                  labelColor: AppColors.black,
                  hintColor: AppColors.black,
                  fillColor: AppColors.black.withAlpha(12),
                  prefixColor: Colors.black,
                ),
                const SizedBox(height: 16),

                // Date Picker
                GestureDetector(
                  onTap: pickDate,
                  child: AbsorbPointer(
                    child: InputField(
                      controller: dateController,
                      labelShow: false,
                      hintText: "Select Date",
                      keyboardType: TextInputType.datetime,
                      prefixIcon: AppIcons.calender,
                      label: "Date",
                      labelColor: AppColors.black,
                      hintColor: AppColors.black,
                      fillColor: AppColors.black.withAlpha(12),
                      prefixColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Save/Update button
                TextAction(
                  verticalPadding: 12,
                  text: existingConsumer == null ? "Save" : "Update",
                  backgroundColor: Colors.black,
                  circleIcon: Colors.white,
                  onPressed: () {
                    consumerController.validateAndSubmitConsumer(
                      context: context,
                      nameController: nameController,
                      phoneController: phoneController,
                      shopNameController:  shopNameController,
                      totalPriceController: totalPriceController,
                      paidAmountController: paidAmountController,
                      dateController: dateController,
                      pickedImage: pickedImage,
                      existingConsumer: existingConsumer,
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
