import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';

import '../../../../const/res/app_color.dart';
import '../../../../models/admin/company_model.dart';
import '../../../../widgets/add_company_widget.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/company_card.dart';

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  final companyController = Get.put(CompanyController());

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      companyController.isLoading.value = true;
      await companyController.fetchCompanies();
      companyController.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Company"),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.c5669ff,
            onPressed: () {
              Get.bottomSheet(
                buildCompany(context),
                backgroundColor: AppColors.white,
              );
            },
            child: const Icon(Icons.add, color: AppColors.white),
          ),
          body: Obx(() {
            if (companyController.companyList.isEmpty &&
                !companyController.isLoading.value) {
              return const Center(child: AppText(text: "No Companies Found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              itemCount: companyController.companyList.length,
              itemBuilder: (context, index) {
                final CompanyModel company =
                    companyController.companyList[index];
                return companyCard(context, company);
              },
            );
          }),
        ),

        // Loader Overlay
        Obx(() {
          if (!companyController.isLoading.value) {
            return const SizedBox.shrink();
          }
          return Container(
            color: Colors.black45, // semi-transparent background
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
      ],
    );
  }
}
