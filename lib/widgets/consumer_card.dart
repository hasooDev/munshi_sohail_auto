import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/consumer_data_controller.dart';
import 'package:sohail_auto/models/admin/consumer_data_model.dart';
import 'package:sohail_auto/widgets/add_consumer_data_widget.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../const/res/app_color.dart';

Widget consumerCard(BuildContext context, ConsumerModel consumer) {
  final consumerController = Get.find<ConsumerController>();

  return Card(
    color: AppColors.white,
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 6,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Image with PopupMenu ----------
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (consumer.billImagePath != null) {
                  Get.dialog(
                    Center(
                      child: InteractiveViewer(
                        panEnabled: true,
                        boundaryMargin: const EdgeInsets.all(10),
                        child: Image.file(File(consumer.billImagePath!)),
                      ),
                    ),
                    barrierColor: Colors.black54,
                  );
                }
              },
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  color: AppColors.c5669ff.withOpacity(0.1),
                  image: consumer.billImagePath != null
                      ? DecorationImage(
                          image: FileImage(File(consumer.billImagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: consumer.billImagePath == null
                    ? const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.c5669ff,
                          size: 40,
                        ),
                      )
                    : null,
              ),
            ),

            // ---------- Popup Menu in Top Left ----------
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'Update') {
                      Get.bottomSheet(
                        buildConsumer(context, existingConsumer: consumer),
                        backgroundColor: AppColors.white,
                      );
                    } else if (value == 'Delete') {
                      consumerController.consumerDeleteDialog(
                        consumerName: consumer.name,
                        onDelete: () {
                          consumerController.deleteConsumer(consumer.id!);
                        },
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Update',
                      child: AppText(
                        text: "Update",
                        fontWeight: FontWeight.w700,
                        color: AppColors.c5669ff,
                      ),
                    ),
                    const PopupMenuItem(
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
            Positioned(
              bottom: 12,right: 12,
              child: Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AppText(
                  text: "Total Balance: Rs ${consumer.totalPrice}",
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),

        // ---------- Consumer Info ----------
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: consumer.name,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              if (consumer.shopName.isNotEmpty)
                AppText(
                  text: "Shop Name: ${consumer.shopName}",
                  fontSize: 14,
                  color: AppColors.c979797,
                ),
              AppText(
                text: "Phone #: ${consumer.phone}",
                fontSize: 14,
                color: AppColors.c979797,
              ),

              AppText(
                text: "Paid Balance: ${consumer.paidAmount}",
                fontSize: 14,
                color: Colors.green,
              ),
              AppText(
                text: "Remaining Balance: ${consumer.remainingAmount}",
                fontSize: 14,
                color: Colors.red,
              ),
              AppText(
                text: "Date : ${consumer.date}",
                fontSize: 14,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
