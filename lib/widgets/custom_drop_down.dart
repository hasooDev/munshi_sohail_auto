import 'package:flutter/material.dart';

import '../res/app_color.dart';
import 'app_text.dart';
class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final Function(T?) onChanged;
  final String Function(T item) itemLabelBuilder;
  final String iconAsset;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemLabelBuilder,
    required this.hintText,
    required this.iconAsset,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool isExpanded = false;

  void toggleDropdown() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedLabel = widget.selectedItem != null
        ? widget.itemLabelBuilder(widget.selectedItem as T)
        : null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cdadee3, width: 1),
        color: AppColors.black.withAlpha(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: toggleDropdown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
              child: Row(
                children: [
                  Image.asset(widget.iconAsset, height: 20, width: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText(
                      text: selectedLabel ?? widget.hintText,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black,
                    ),
                  ),
                  Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.black.withAlpha(7),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return InkWell(
                    onTap: () {
                      widget.onChanged(item);
                      setState(() {
                        isExpanded = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
                      child: AppText(
                        text: widget.itemLabelBuilder(item),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
