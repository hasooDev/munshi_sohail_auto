import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/company_controller.dart';

import '../../../../models/admin/company_model.dart';
import '../../../../res/app_color.dart';
import '../../../../res/app_icons.dart';
import '../../../../widgets/add_company_widget.dart';
import '../../../../widgets/app_text.dart';
class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  final companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: AppText(
          text: 'Companies',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.c5669ff),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        shadowColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 0,

      ),
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

        if (companyController.companyList.isEmpty) {
          return const Center(child: AppText(text: "No Companies Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          itemCount: companyController.companyList.length,
          itemBuilder: (context, index) {
            final CompanyModel company = companyController.companyList[index];

            return Card(
              color: AppColors.white,
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with popup menu icon in top-right
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                                bottom: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image:
                                    company.imagePath != null &&
                                        company.imagePath!.isNotEmpty
                                    ? FileImage(File(company.imagePath!))
                                          as ImageProvider
                                    : AssetImage(AppIcons.user),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            color: AppColors.white,
                            onSelected: (value) {
                              if (value == 'Edit') {
                                Get.bottomSheet(
                                  buildCompany(
                                    context,
                                    existingCompany: company,
                                  ),
                                  backgroundColor: AppColors.white,
                                );
                              } else if (value == 'Delete') {
                                companyController.companyDeleteDialog(
                                  companyId: company.name,
                                  onDelete: () => companyController
                                      .deleteCompany(company.id!),
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
                    ],
                  ),
                  // Company Name
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0,bottom: 7,left: 12),
                    child: RichText(text: TextSpan(
                        text: "Company : ",
                        style: TextStyle(
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: AppColors.softRed,
                        ),
                        children: [
                          TextSpan(
                            text: company.name,
                            style: TextStyle(
                              fontFamily: "Lexend",
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              color: AppColors.black,
                            )
                          )
                        ]))
                  ),

                ],
              ),
            );
          },
        );
      }),
    );
  }
}
