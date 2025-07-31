import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

import '../../../../res/app_color.dart';
import '../../../../widgets/app_text.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: 'Customer',
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
      backgroundColor: AppColors.white,
      body: Center(
        child: AppText(text: "No Customer",fontSize: 14,),
      ),
    );
  }
}
