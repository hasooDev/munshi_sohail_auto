import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/widgets/company_label.dart';

import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import '../features/controller/company_controller.dart';
import '../models/admin/company_model.dart';
import 'add_company_widget.dart';
import 'app_text.dart';

Widget companyCard(BuildContext context, CompanyModel company) {
  final companyController = Get.put(CompanyController());

  return Card(
    elevation: 6,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias, // Ensures children respect rounded corners
    child: Stack(
      children: [
        // Background Image
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  (company.imagePath != null && company.imagePath!.isNotEmpty)
                  ? FileImage(File(company.imagePath!)) as ImageProvider
                  : AssetImage(AppIcons.user),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient overlay for readability
        Container(
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // ignore: deprecated_member_use
                Colors.black.withOpacity(0.5),
                Colors.transparent,
                // ignore: deprecated_member_use
                Colors.black.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Popup menu (top right)
        Positioned(
          top: 10,
          right: 10,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: PopupMenuButton<String>(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              icon: const Icon(Icons.more_vert, color: Colors.white),
              color: AppColors.white,
              onSelected: (value) {
                if (value == 'Edit') {
                  Get.bottomSheet(
                    buildCompany(context, existingCompany: company),
                    backgroundColor: AppColors.white,
                  );
                } else if (value == 'Delete') {
                  companyController.companyDeleteDialog(
                    companyId: company.name,
                    onDelete: () {
                      companyController.deleteCompany(company.id!);
                       
                    },
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

        // Company name (bottom left)
        Positioned(
          left: 16,
          bottom: 16,
          child: CompanyLabel(companyName: company.name),
        ),
      ],
    ),
  );
}
