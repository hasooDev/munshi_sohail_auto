import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/const/res/app_color.dart';
import 'package:sohail_auto/models/user/customer_model.dart';
import 'package:sohail_auto/features/controller/product_controller.dart';

import '../features/controller/cart_controller.dart';

class CartBottomSheet extends StatelessWidget {
  final RxMap<int?, int?> cart;
  final Customermodel customer;
  final ProductController productController;

  const CartBottomSheet({
    super.key,
    required this.cart,
    required this.customer,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Container(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(() {
        final selectedProducts = productController.filteredProductList
            .where((p) => cart.containsKey(p.id))
            .toList();

        if (selectedProducts.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: AppText(text: "No items selected.")),
          );
        }

        double totalPrice = selectedProducts.fold(
          0.0,
              (sum, p) => sum + (p.pricePerUnit * cart[p.id]!),
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 10),
            const AppText(
              text: "Your Cart",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const Divider(),
            ...selectedProducts.map((p) {
              return ListTile(
                leading: p.imagePath.isNotEmpty
                    ? Image.file(File(p.imagePath), width: 50, height: 50)
                    : const Icon(Icons.image, size: 40),
                title: AppText(text: p.name),
                subtitle:
                AppText(text: "Rs. ${p.pricePerUnit * cart[p.id]!}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (cart[p.id]! > 1) {
                          cart[p.id] = cart[p.id]! - 1;
                        } else {
                          cart.remove(p.id);
                        }
                      },
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                    ),
                    AppText(
                      text: "${cart[p.id]}",
                      fontWeight: FontWeight.bold,
                    ),
                    GestureDetector(

                      onTap: () {
                        cart[p.id] = cart[p.id]! + 1;
                      },

                      child:
                      const Icon(Icons.add_circle, color: Colors.green),
                    ),
                  ],
                ),
              );
            }),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "Total: Rs. $totalPrice",
                    fontWeight: FontWeight.bold,
                  ),
                  ElevatedButton(
                    onPressed: () {

                      // Go to next screen (e.g., order summary)
                      Get.snackbar("Next Step", "Proceed to order placement");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.c5669ff,
                    ),
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
