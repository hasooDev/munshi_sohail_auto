import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

  void showCustomBottomSheet({
    required BuildContext context,
    required Widget child,
    double borderRadius = 14,
    Color backgroundColor = Colors.white,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Needed for full height + keyboard
      backgroundColor: Colors.transparent, // So we can wrap with padding
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ keyboard space
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
          ),
          child: SingleChildScrollView(
            // ✅ Scroll if content is long
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: child,
          ),
        ),
      ),
    );
  }


}
