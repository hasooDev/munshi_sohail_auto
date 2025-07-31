import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/widgets/text_action.dart';

import '../../models/admin/company_model.dart';
import '../../res/app_color.dart';
import '../../services/database_helper.dart';
import '../../widgets/app_text.dart';
class CompanyController extends GetxController {
  RxList<CompanyModel> companyList = <CompanyModel>[].obs;
  RxList<CompanyModel> filteredCompanyList = <CompanyModel>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    fetchCompanies();

    // Watch for changes in searchQuery or companyList and update the filtered list
    everAll([searchQuery, companyList], (_) => _filterCompanies());

    super.onInit();
  }

  Future<void> fetchCompanies() async {
    final companies = await DatabaseHelper().getCompanies();
    companyList.assignAll(companies);
    _filterCompanies(); // Update filtered list after fetching
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _filterCompanies() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredCompanyList.assignAll(companyList);
    } else {
      filteredCompanyList.assignAll(
        companyList.where(
              (c) => c.name.toLowerCase().contains(query),
        ),
      );
    }
  }

  Future<void> addCompany(CompanyModel company) async {
    await DatabaseHelper().insertCompany(company);
    await fetchCompanies();
  }

  Future<void> updateCompany(CompanyModel company) async {
    await DatabaseHelper().updateCompany(company);
    await fetchCompanies();
  }

  Future<void> deleteCompany(int id) async {
    await DatabaseHelper().deleteCompany(id);
    await fetchCompanies();
  }

  Future<void> companyDeleteDialog({
    required String? companyId,
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
                text: "Delete Company",
                color: AppColors.ceb5757,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 10),
              AppText(
                text: "Are you sure you want to delete $companyId ?",
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
                  Get.back(); // Close the dialog
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

  Future<void> validateAndSubmitCompany({
    required BuildContext context,
    required TextEditingController brandController,
    File? pickedImage,
    CompanyModel? existingCompany,
  }) async {
    String name = brandController.text.trim();

    if (name.isEmpty) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        icon: Icon(Icons.error, color: Colors.white),
        "",
        "",
        titleText: AppText(text: "Error", color: AppColors.white),
        messageText: AppText(
          text: "Company name is required",
          color: AppColors.white,
        ),
      );
      return;
    }

    final company = CompanyModel(
      id: existingCompany?.id,
      name: name,
      imagePath: pickedImage?.path,
    );

    if (existingCompany == null) {
      await addCompany(company);
    } else {
      await updateCompany(company);
    }

    brandController.clear();
    Get.back();
    Get.snackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      icon: Icon(Icons.done_outline, color: Colors.white),
      "",
      "",
      titleText: AppText(text: "Success", color: AppColors.white, fontWeight: FontWeight.w800, fontSize: 15),
      messageText: AppText(
        text: existingCompany == null ? "Company added BAWA G !!!!" : "Company Updated Huraaaah !!!!",
        color: AppColors.white,
      ),
    );
  }
}
