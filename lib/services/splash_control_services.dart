import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/routes/app_routes.dart';

class SplashControllService extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  /// Navigate to the next screen after splash
  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 7 )); // splash delay

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final userRole = prefs.getInt('role') ?? 0;

    if (isLoggedIn) {
      // Logged in → check role
      if (userRole == 1) {
        Get.offAllNamed(AppRoutes.admin);
      } else {
        Get.offAllNamed(AppRoutes.main);
      }
    } else {
      // Not logged in → go to login/auth
      Get.offAllNamed(AppRoutes.auth);
    }
  }
}
