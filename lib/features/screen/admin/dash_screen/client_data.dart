import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../../../../res/app_color.dart';

class ClientData extends StatefulWidget {
  const ClientData({super.key});

  @override
  State<ClientData> createState() => _ClientDataState();
}

class _ClientDataState extends State<ClientData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const AppText(
          text: 'Client Data',
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
      body: Center(
        child: AppText(text: "No Client data Found"),
      ),
    );
  }
}
