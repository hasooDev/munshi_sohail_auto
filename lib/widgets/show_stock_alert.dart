/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/product _model.dart';

void showLowStockDialog(List<ProductModel> lowStockItems) {
  Get.dialog(
    AlertDialog(
      title: const Text("⚠️ Stock Alert"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lowStockItems.length,
          itemBuilder: (context, index) {
            final product = lowStockItems[index];
            return ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.red),
              title: Text(product.name),
              subtitle: Text("Only ${product.quantityInStock} in stock"),
              trailing: Text("Min: ${product.minStockAlert}"),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Close", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
*/
