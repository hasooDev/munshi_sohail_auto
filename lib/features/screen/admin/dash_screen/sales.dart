import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/user/sales_controller.dart';
import '../../../../res/app_color.dart';
import '../../../../widgets/app_text.dart';


class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  final salesController = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const AppText(
          text: 'Sales',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
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
      body: Obx(() {
        if (salesController.salesList.isEmpty) {
          return const Center(
            child: AppText(text: "No sales available.", fontSize: 16),
          );
        }
        return SizedBox.shrink();

      /*  return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: salesController.salesList.length,
          itemBuilder: (context, index) {
            final sale = salesController.salesList[index];
            *//*return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: AppText(
                  text: "Customer: ${sale.customerName}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                subtitle: AppText(
                  text: "Total: ₹${sale.totalAmount}",
                  fontSize: 14,
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.c5669ff),
                onTap: () {
                  // Open sale detail
                },
              ),
            );*//*
          },
        );*/
      }),

    );
  }
}
