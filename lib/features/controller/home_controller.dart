import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'package:sohail_auto/const/routes/app_routes.dart';


class HomeController extends GetxController {
    // var customers = <Customermodel>[].obs;

    // @override
    // void onInit() {
    //     super.onInit();
    //     fetchCustomers();
    //
    // }
    //
    // Future<void> fetchCustomers() async {
    //     final db = DatabaseHelper();
    //     customers.value = await db.getCustomers();
    // }
    //
    // Future<void> addCustomer(Customermodel customer) async {
    //     final db = DatabaseHelper();
    //     await db.insertCustomer(customer);


        // logout
        Future<void> logout() async {
            final prefs = await SharedPreferences.getInstance();

            // Only clear login session, not everything
            await prefs.remove('isLoggedIn');
            await prefs.remove('role');
            Get.offAllNamed(AppRoutes.auth);
        }
    }
