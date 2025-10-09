import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/res/app_images.dart';

Future<void> showMemorialDialog(
  SharedPreferences prefs,
  BuildContext context,
) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Back press won't dismiss
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image
                  SizedBox(height: 12,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      AppImages.maker, // <-- add your image here
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Sub-title
                  Text(
                    "منشی سردار سہیل قریشی اور سردار محمود قریشی",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Emotional Urdu paragraph
                  Text(
                    "یادوں کے چراغ ہمیشہ جلتے رہتے ہیں۔\n"
                    "منشی سردار سہیل قریشی اور سردار محمود قریشی کی محبت، قربانی اور خلوص ہمیشہ ہمارے دلوں میں زندہ رہیں گے۔\n"
                    "یہ سفر ان کی یادوں اور دعاؤں کے سائے میں جاری ہے۔",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Close Button (top-right corner)
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () async {
                  // ✅ Save in SharedPreferences when closed
                  await prefs.setBool("hasSeenMemorialDialog", true);
                  Get.back();
                },
                child: const Icon(Icons.close, color: Colors.black54, size: 24),
              ),
            ),
          ],
        ),
      );
    },
  );
}
