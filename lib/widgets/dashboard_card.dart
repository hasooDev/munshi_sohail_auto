import 'dart:ui';
import 'package:flutter/material.dart';
import '../res/app_color.dart';
import '../utility/app_class.dart';
import 'app_text.dart';

class DashBoardCards extends StatelessWidget {
  final List<DashBoardItem> items;

  const DashBoardCards({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = (screenWidth - 16 * 3) / 2; // Two cards per row with padding

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return SizedBox(
            width: cardSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16) ,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: cardSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    color: AppColors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.iconPath,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        text: item.title,
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
