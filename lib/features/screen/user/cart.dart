import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/const/res/app_color.dart';
import 'package:sohail_auto/features/controller/cart_controller.dart';
import 'package:sohail_auto/features/controller/product_controller.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';

class Cart extends StatelessWidget {
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());

  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "Cart",
        showBack: true,
      ),
      body: Obx(() {
        final cart = cartController.cart;
        if (cart.isEmpty) {
          return const Center(
            child: AppText(text: "🛒 Cart is Empty"),
          );
        }

        final selectedProducts = productController.filteredProductList
            .where((p) => cart.containsKey(p.id))
            .toList();

        double totalPrice = selectedProducts.fold(
          0.0,
              (sum, p) => sum + (p.pricePerUnit * cart[p.id]!),
        );

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  final product = selectedProducts[index];
                  final quantity = cart[product.id]!;

                  return Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: product.imagePath.isNotEmpty
                            ? Image.file(
                          File(product.imagePath),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image),
                        ),
                      ),
                      title: AppText(
                        text: product.name,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: AppText(
                        text:
                        "Rs. ${product.pricePerUnit} x $quantity = Rs. ${(product.pricePerUnit * quantity).toStringAsFixed(2)}",
                        color: Colors.grey[700],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () =>
                                cartController.removeFromCart(product.id!),
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.redAccent),
                          ),
                          AppText(text: "$quantity"),
                          IconButton(
                            onPressed: () =>
                                cartController.addToCart(product.id!),
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green),
                          ),
                          IconButton(
                            onPressed: () =>
                                cartController.deleteItem(product.id!),
                            icon: const Icon(Icons.delete, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "Total: Rs. ${totalPrice.toStringAsFixed(2)}",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cartController.clearCart();
                      Get.snackbar("Cart Cleared", "All items removed",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.c5669ff,
                    ),
                    child: const Text("Clear All"),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
