import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/res/theme.dart';
import 'package:sohail_auto/routes/app_pages.dart';
import 'package:sohail_auto/routes/app_routes.dart';

import 'features/controller/auth_controller.dart';

class MunshiSohailAuto extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  MunshiSohailAuto({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _authController.checkLoginStatus());
    return FutureBuilder(
      future: _authController.checkLoginStatus(),
      builder: (context, snapshot) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Munshi Sohail Auto',
          darkTheme: darkMode,
          initialRoute: AppRoutes.auth,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
