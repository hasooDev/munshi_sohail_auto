// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohail_auto/const/res/app_icons.dart';
import 'package:sohail_auto/const/routes/app_routes.dart';

import '../../../services/database_helper.dart';
import '../../const/res/app_color.dart';
import '../../const/res/app_strings.dart';
import '../../utility/storage_services.dart';
import '../../widgets/app_text.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = Get.find<StorageService>();
  final isLoading = false.obs;
  final loader = SpinKitFadingCircle(
    color: Colors.black.withOpacity(0.5),
    size: 36,
  );
  /*validate the Login */
  void validateAndLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showError(AppStrings.emailAndPasswordRequired);
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = true; // ✅ Start loader

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Try both roles: 1 = Admin, 0 = User
      for (int role in [1, 0]) {
        final user = await DatabaseHelper().authenticateUserByRole(
          email: email,
          password: password,
          role: role,
        );

        if (user != null) {
          await saveLoginSession(user.role);

          if (user.role == 1) {
            Get.offAllNamed(AppRoutes.admin);

          } else {
            Get.offAllNamed(AppRoutes.main);

          }

          emailController.clear();
          passwordController.clear();
          Get.snackbar(
            "",
            "",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.black.withOpacity(0.4),
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(12),
            borderRadius: 8,
            titleText: AppText(
              text: "Welcome Back",
              color: AppColors.softRed,
              fontWeight: FontWeight.w900,
            ),
            messageText: AppText(
              text: "Munshi Sohail Auto",
              color: Colors.white,
              fontSize: 15,

            ),
            icon: Image(image: AssetImage(AppIcons.welcome), width: 23, height: 23),
          );
          isLoading.value = false; // ✅ Stop loader before return
          return;
        }
      }

      // If no match found
      showError(AppStrings.invalidCredential);
    } catch (e) {
      showError("Something went wrong: $e");
    } finally {

      isLoading.value = false; // ✅ Always stop loader
    }
  }

  /*  On successful login*/
  Future<void> saveLoginSession(int role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setInt('role', role);
  }

  /* Logout Function*/
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Only clear login session, not everything
    await prefs.remove('isLoggedIn');
    await prefs.remove('role');
    Get.offAllNamed(AppRoutes.auth);
  }

  /* Error SnackBar */
  void showError(String message) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      icon: Icon(Icons.error, color: Colors.redAccent),
      titleText: AppText(
        text: AppStrings.error,
        color: Colors.brown,
        fontWeight: FontWeight.w800,
      ),
      messageText: AppText(
        text: message,
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

}
// /* login status Check */
// Future<void> checkLoginStatus() async {
//   final prefs = await SharedPreferences.getInstance();
//   final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//   final userRole = prefs.getInt('role') ?? 0;
//
//   if (isLoggedIn) {
//     if (userRole == 1) {
//       Get.offAllNamed(AppRoutes.admin); // Adjust to your admin route
//     } else {
//       Get.offAllNamed(AppRoutes.home); // User home route
//     }
//   } else {
//     Get.offAllNamed(AppRoutes.auth);
//   }
// }