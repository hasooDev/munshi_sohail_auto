
/* App Pages */
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sohail_auto/features/screen/admin/dash_screen/client_data.dart';
import 'package:sohail_auto/features/screen/auth/auth_screen.dart';
import 'package:sohail_auto/features/screen/user/home.dart';
import 'package:sohail_auto/features/screen/user/main_screen.dart';
import 'package:sohail_auto/features/screen/user/product_screen.dart';
import 'package:sohail_auto/widgets/customer_list.dart';

import '../../features/screen/admin/admin_screen.dart';
import '../../features/screen/admin/dash_screen/back_restore.dart';
import '../../features/screen/admin/dash_screen/category.dart';
import '../../features/screen/admin/dash_screen/company.dart';
import '../../features/screen/admin/dash_screen/customer.dart';
import '../../features/screen/admin/dash_screen/product.dart';
import '../../features/screen/admin/dash_screen/sales.dart';
import '../../features/screen/auth/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    /* Splash Screen */

    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Auth Screen */

    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Main Screen*/
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* USER Home Screen */
    GetPage(
      name: AppRoutes.home,
      page: () => const Home(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* admin Panel */
    GetPage(
      name: AppRoutes.admin,
      page: () => const AdminScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Company */
    GetPage(
      name: AppRoutes.company,
      page: () =>  Company(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Category */
    GetPage(
      name: AppRoutes.category,
      page: () => const  Category(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Product */
    GetPage(
      name: AppRoutes.product,
      page: () => const Product(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Customer */
    GetPage(
      name: AppRoutes.customer,
      page: () => const Customer(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Customer List */
    GetPage(
      name: AppRoutes.customerList,
      page: () =>  CustomerList(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* sales */
    GetPage(
      name: AppRoutes.sales,
      page: () => const Sales(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Client Data */
    GetPage(
      name: AppRoutes.clientData,
      page: () => const ClientData(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
    /* Backup / Restore */
    GetPage(
      name: AppRoutes.backup,
      page: () => const BackUp(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
/* Product Screen(user side )*/
    GetPage(
      name: AppRoutes.productScreen,
      page: () =>  ProductScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 700),
    ),
  ];
}