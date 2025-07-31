import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohail_auto/res/app_strings.dart';
import 'package:sohail_auto/routes/app_routes.dart';

import '../../../services/database_helper.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /*validate the Login */
  void validateAndLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showError(AppStrings.emailAndPasswordRequired);
      return;
    }

    /* Try both roles: 1 = Admin, 0 = User*/
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
          Get.offAllNamed(AppRoutes.home);
        }

        emailController.clear();
        passwordController.clear();
        return;
      }
    }
    showError(AppStrings.invalidCredential);
  }

  /* login status Check */
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final userRole = prefs.getInt('role') ?? 0;

    if (isLoggedIn) {
      if (userRole == 1) {
        Get.offAllNamed(AppRoutes.admin); // Adjust to your admin route
      } else {
        Get.offAllNamed(AppRoutes.home); // User home route
      }
    } else {
      Get.offAllNamed(AppRoutes.auth);
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
    await prefs.clear();
    Get.offAllNamed(AppRoutes.auth);
  }

  /* Error SnackBar */
  void showError(String message) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      icon: Icon(Icons.error, color: Colors.white),
      titleText: Text(
        AppStrings.error,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(message, style: TextStyle(color: Colors.white)),
    );
  }
}
