import 'package:flutter/material.dart';

import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import 'app_text.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final VoidCallback onLogout;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {"icon": AppIcons.home, "label": "Home"},
      {"icon": AppIcons.cart, "label": "Cart"},
    ];

    return Padding(
      padding: const EdgeInsets.only(  bottom: 23.0),
      child: Container(
        height: 65,

        margin: const EdgeInsets.symmetric(horizontal: 85),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: AppColors.cffcd6c.withAlpha(78),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(navItems.length, (index) {
            final item = navItems[index];
            final bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () => onTap(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item["icon"],
                    height: isSelected ? 24 : 17,
                    color: isSelected ? AppColors.black : Colors.grey.shade400,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    text: item["label"],
                    fontSize: 12,
                    fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                    color:
                    isSelected ? AppColors.black : Colors.grey.shade400,
                  ),

                  /// 🔹 Small underline indicator
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    height: 3,
                    width: 20,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.black
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
