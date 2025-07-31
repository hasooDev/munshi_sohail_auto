import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/auth_controller.dart';
import 'package:sohail_auto/res/app_color.dart';
import 'package:sohail_auto/widgets/app_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                     authController.logout();
                  },
                  child: AppText(text: "Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
