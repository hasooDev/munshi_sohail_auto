import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/const/routes/app_routes.dart';

import '../../const/res/app_color.dart';
import '../../models/user/customer_model.dart'; // <-- use only this
import '../../services/database_helper.dart';
import '../../widgets/app_text.dart';

class CustomerController extends GetxController {
  /// All customers from DB
  var customers = <Customermodel>[].obs;

  /// Filtered list for search
  var filteredCustomers = <Customermodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomer();
  }

  /// Get all customers
  Future<void> fetchCustomer() async {
    final dbCustomers = await DatabaseHelper().getCustomers();
    customers.assignAll(dbCustomers);
    filteredCustomers.assignAll(dbCustomers); // default show all
  }

  /// Insert new customer
  Future<void> addCustomer(Customermodel customer) async {
    await DatabaseHelper().insertCustomer(customer);
    await fetchCustomer();
  }

  /// Update existing
  Future<void> updateCustomer(Customermodel customer) async {
    await DatabaseHelper().updateCustomer(customer);
    await fetchCustomer();
  }

  /// Delete customer
  Future<void> deleteCustomer(int id) async {
    await DatabaseHelper().deleteCustomer(id);
    await fetchCustomer();
  }

  /// 🔎 Search function
  void searchCustomer(String query) {
    if (query.isEmpty) {
      filteredCustomers.assignAll(customers);
    } else {
      filteredCustomers.assignAll(
        customers.where((c) =>
        c.name.toLowerCase().contains(query.toLowerCase()) ||
            c.phone.toLowerCase().contains(query.toLowerCase())
        ).toList(),
      );
    }
  }

  /// ✅ Update payment for dummy UI calculation
  // void updatePayment(int customerId, double amount) {
  //   final customer = customers.firstWhereOrNull((c) => c.id == customerId);
  //   if (customer != null) {
  //     // Only if you track paid/remaining in Customermodel
  //     customer.totalPaid = (customer.totalPaid ?? 0) + amount;
  //     customer.totalRemaining =
  //         (customer.totalAmount ?? 0) - (customer.totalPaid ?? 0);
  //     customers.refresh();
  //     filteredCustomers.refresh();
  //   }
  // }

  /// ✅ Validation + Add/Update logic
  Future<void> validateAndSubmitCustomer({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController dateController,
    Customermodel? existingCustomer,
  }) async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String date = dateController.text.trim();

    if (name.isEmpty) {
      _showError("Customer name is required");
      return;
    }

    if (phone.isEmpty) {
      _showError("Phone number is required");
      return;
    }

    if (date.isEmpty) {
      _showError("Please select a date");
      return;
    }

    final customer = Customermodel(
      id: existingCustomer?.id,
      name: name,
      phone: phone,
      date: date,
    );

    if (existingCustomer == null) {
      await addCustomer(customer);
    } else {
      await updateCustomer(customer);
    }

    nameController.clear();
    phoneController.clear();
    dateController.clear();

    Get.back();
    Get.toNamed(
      AppRoutes.productScreen,
      arguments: customer, // pass the full customer model
    );

    Get.snackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      icon: const Icon(Icons.done_outline, color: Colors.white),
      "",
      "",
      titleText: const AppText(
        text: "Success",
        color: AppColors.white,
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
      messageText: const AppText(
        text: "Customer saved successfully 🎉",
        color: AppColors.white,
      ),
    );
  }

  /// Reusable error snack
  void _showError(String message) {
    Get.snackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
      "",
      "",
      titleText: const AppText(text: "Error", color: AppColors.white),
      messageText: AppText(text: message, color: AppColors.white),
    );
  }
}
