import 'package:flutter/material.dart';

import '../res/app_color.dart';
import 'app_text.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final String? iconPath; // Add icon path
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.title,
    this.iconPath,
    this.onTap,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color: AppColors.black.withAlpha(11),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title with Icon (if exists)
                Row(
                  children: [
                    if (widget.iconPath != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          widget.iconPath!,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    AppText(
                      text: widget.title,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ],
                ),

                // Trailing arrow icon
                GestureDetector(
                  onTap: widget.onTap,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: AppColors.ceb5757,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Assuming this is your ItemCard widget

class ItemCardGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ItemCardGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 16 * 3) / 2; // 2 cards per row with 16px spacing

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: items.map((item) {
          return SizedBox(
            width: cardWidth,
            child: ItemCard(
              title: item['title'],
              iconPath: item['iconPath'],
              onTap: item['onTap'],
            ),
          );
        }).toList(),
      ),
    );
  }
}
