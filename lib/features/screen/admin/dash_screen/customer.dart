import 'package:flutter/material.dart';

import '../../../../const/res/app_color.dart';
import '../../../../widgets/app_text.dart';
import '../../../controller/customer_controller.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  void _showUpdateDialog(BuildContext context, CustomerController controller, int customerId) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const AppText(
          text: "Update Payment",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Enter Paid Amount",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.c5669ff),
            child: const Text("Update"),
            onPressed: () {
              final paid = double.tryParse(amountController.text) ?? 0;
              // controller.updatePayment(customerId, paid);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
    // final customerController = Get.put(CustomerController());
    //
    // return Scaffold(
    //   appBar: CustomAppBar(title: "Customers"),
    //   backgroundColor: AppColors.white,
    //   body: Obx(() {
    //     if (customerController.customerList.isEmpty) {
    //       return const Center(
    //         child: AppText(
    //           text: "No Customers Found",
    //           fontSize: 16,
    //           color: AppColors.c979797,
    //         ),
    //       );
    //     }
    //
    //     return ListView.builder(
    //       itemCount: customerController.customerList.length,
    //       itemBuilder: (context, index) {
    //         final customer = customerController.customerList[index];
    //
    //         return Card(
    //           color: Colors.white,
    //           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16)),
    //           elevation: 4,
    //           child: ExpansionTile(
    //             leading: const CircleAvatar(
    //               backgroundColor: AppColors.c5669ff,
    //               child: Icon(Icons.person, color: Colors.white),
    //             ),
    //             title: AppText(
    //               text: customer.name,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 18,
    //             ),
    //             subtitle: AppText(
    //               text: customer.phone,
    //               fontSize: 14,
    //               color: AppColors.c979797,
    //             ),
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const AppText(
    //                       text: "Purchased Products:",
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 16,
    //                     ),
    //                     ...customer.purchases.map((p) => ListTile(
    //                           dense: true,
    //                           contentPadding: EdgeInsets.zero,
    //                           title: AppText(
    //                             text: "${p.productName} (x${p.quantity})",
    //                             fontSize: 14,
    //                           ),
    //                           trailing: AppText(
    //                             text: "Rs. ${p.price * p.quantity}",
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.w600,
    //                             color: AppColors.c5669ff,
    //                           ),
    //                         )),
    //                     const Divider(),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         AppText(
    //                           text: "Total: Rs. ${customer.totalAmount}",
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                         AppText(
    //                           text: "Paid: Rs. ${customer.totalPaid}",
    //                           fontWeight: FontWeight.w600,
    //                           color: Colors.green,
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 6),
    //                     AppText(
    //                       text: "Remaining: Rs. ${customer.totalRemaining}",
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 16,
    //                       color: Colors.red,
    //                     ),
    //                     const SizedBox(height: 10),
    //                     Align(
    //                       alignment: Alignment.centerRight,
    //                       child: ElevatedButton.icon(
    //                         onPressed: () => _showUpdateDialog(context, customerController, customer.id),
    //                         icon: const Icon(Icons.edit, size: 18, color: Colors.white),
    //                         label: const Text("Update Payment"),
    //                         style: ElevatedButton.styleFrom(
    //                           backgroundColor: AppColors.c5669ff,
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(8),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // );
  }
}
