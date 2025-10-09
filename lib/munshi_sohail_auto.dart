import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'const/res/theme.dart';
import 'const/routes/app_pages.dart';
import 'const/routes/app_routes.dart';
import 'features/bindings/splash_bindings.dart';

class MunshiSohailAuto extends StatelessWidget {
 const  MunshiSohailAuto({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Munshi Sohail Auto',
      theme: ThemeData(
        fontFamily: "Lufga"
      ),
      darkTheme: darkMode,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,

    );
  }
}
