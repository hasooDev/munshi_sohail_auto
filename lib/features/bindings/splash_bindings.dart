import 'package:get/get.dart';

import '../../services/splash_control_services.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashControllService());
  }
}