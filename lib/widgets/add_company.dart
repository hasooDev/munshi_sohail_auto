import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../features/controller/auth_controller.dart';
import '../res/app_color.dart';
import '../res/app_icons.dart';
import 'app_text.dart';
import 'input_field.dart';
import 'text_action.dart';

Widget buildAddCompanySheet(BuildContext context) {
  final authController = Get.put(AuthController());
  final TextEditingController brandController = TextEditingController();
  final TextEditingController inventoryController = TextEditingController(text: '0');
  final ImagePicker picker = ImagePicker();

  int inventory = 0;
  File? pickedImage;

  return StatefulBuilder(
    builder: (context, setState) {
      Future<void> pickImage() async {
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            pickedImage = File(image.path);
          });
        }
      }

      return SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: "Add Category",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 24),

            // Image Picker
            Center(
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                    image: pickedImage != null
                        ? DecorationImage(
                      image: FileImage(pickedImage!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: pickedImage == null
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Add Brand Image",
                style: TextStyle(fontFamily: 'Lexend'),
              ),
            ),

            const SizedBox(height: 24),

            // Brand Name Field
            InputField(
              controller: brandController,
              labelShow: false,
              hintText: "Enter the Brand Name",
              keyboardType: TextInputType.text,
              prefixIcon: AppIcons.mail,
              label: "Brand Name",
              labelColor: AppColors.black,
              hintColor: AppColors.black,
              fillColor: Colors.black.withOpacity(0.1),
              prefixColor: Colors.black,
            ),

            const SizedBox(height: 16),

            // Inventory Input + Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inventory',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Lexend'),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (inventory > 0) {
                          setState(() {
                            inventory--;
                            inventoryController.text = inventory.toString();
                          });
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Container(
                      width: 60,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: inventoryController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontFamily: "Lexend"),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (val) {
                          final parsed = int.tryParse(val);
                          if (parsed != null) {
                            setState(() => inventory = parsed);
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          inventory++;
                          inventoryController.text = inventory.toString();
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            TextAction(
              text: 'Submit',
              onPressed: () {

              },
            ),
          ],
        ),
      );
    },
  );
}
