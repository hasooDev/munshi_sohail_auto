import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/auth_controller.dart';
import 'package:sohail_auto/features/screen/user/cart.dart';
import 'package:sohail_auto/features/screen/user/home.dart';
import 'package:sohail_auto/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeController = Get.put(AuthController());
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
     Cart()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onLogout: () {
          homeController.logout();
        },
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
