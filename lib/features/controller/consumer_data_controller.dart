import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/models/admin/consumer_data_model.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/text_action.dart';

import '../../const/res/app_color.dart';
import '../../services/database_helper.dart';

class ConsumerController extends GetxController {
  RxList<ConsumerModel> consumerList = <ConsumerModel>[].obs;
  RxList<ConsumerModel> filteredConsumerList = <ConsumerModel>[].obs;
  RxString searchQuery = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchConsumers();
    // Watch for changes in searchQuery or consumerList and update the filtered list
    everAll([searchQuery, consumerList], (_) => _filterConsumers());
    super.onInit();
  }

  Future<void> fetchConsumers() async {
    final consumers = await DatabaseHelper().getConsumers();
    consumerList.assignAll(consumers);
    _filterConsumers();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _filterConsumers() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredConsumerList.assignAll(consumerList);
    } else {
      filteredConsumerList.assignAll(
        consumerList.where((c) => c.name.toLowerCase().contains(query)),
      );
    }
  }

  Future<void> addConsumer(ConsumerModel consumer) async {
    await DatabaseHelper().insertConsumer(consumer);
    await fetchConsumers();
  }

  Future<void> updateConsumer(ConsumerModel consumer) async {
    await DatabaseHelper().updateConsumer(consumer);
    await fetchConsumers();
  }

  Future<void> deleteConsumer(int id) async {
    await DatabaseHelper().deleteConsumer(id);
    await fetchConsumers();
  }

  Future<void> consumerDeleteDialog({
    required String? consumerName,
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
                text: "Delete Consumer",
                color: AppColors.ceb5757,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 10),
              AppText(
                text: "Are you sure you want to delete $consumerName ?",
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
                  onDelete();
                  Get.back();
                  Get.snackbar(
                    "Deleted",
                    "Consumer $consumerName successfully deleted",
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

 Future<void> validateAndSubmitConsumer({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController phoneController,
  required TextEditingController shopNameController,
  required TextEditingController totalPriceController,
  required TextEditingController paidAmountController,
  required TextEditingController dateController,
  File? pickedImage,
  ConsumerModel? existingConsumer,
}) async {
  String name = nameController.text.trim();
  String phone = phoneController.text.trim();
  String shopName = shopNameController.text.trim();
  double totalPrice = double.tryParse(totalPriceController.text.trim()) ?? 0.0;
  double paidAmount = double.tryParse(paidAmountController.text.trim()) ?? 0.0;
  String date = dateController.text.trim();

  if (name.isEmpty || phone.isEmpty || shopName.isEmpty || totalPrice <= 0) {
    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
      titleText: const AppText(text: "Error", color: AppColors.white),
      messageText: const AppText(
        text: "All fields are required",
        color: AppColors.white,
      ),
    );
    return;
  }

  final consumer = ConsumerModel(
    id: existingConsumer?.id,
    name: name,
    phone: phone,
    shopName: shopName,
    totalPrice: totalPrice,
    paidAmount: paidAmount,
    remainingAmount: totalPrice - paidAmount,
    billImagePath: pickedImage?.path ?? existingConsumer?.billImagePath,
    date: date.isNotEmpty ? date : DateTime.now().toIso8601String(),
  );

  if (existingConsumer == null) {
    await addConsumer(consumer);
  } else {
    await updateConsumer(consumer);
  }

  nameController.clear();
  phoneController.clear();
 shopNameController.clear();
  totalPriceController.clear();
  paidAmountController.clear();
  dateController.clear();

  Get.back();
  Get.snackbar(
    "",
    "",
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(12),
    borderRadius: 8,
    icon: const Icon(Icons.done_outline, color: Colors.white),
    titleText: const AppText(
      text: "Success",
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      fontSize: 15,
    ),
    messageText: AppText(
      text: existingConsumer == null
          ? "Consumer Added Successfully 🎉 "
          : "Consumer Updated 🎯",
      color: AppColors.white,
    ),
  );
}

}
