import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/const/routes/app_routes.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';
import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';
import '../features/controller/customer_controller.dart';
import 'app_text.dart';
import 'input_field.dart';
import 'package:intl/intl.dart'; // ✅ for date formatting/parsing

class CustomerList extends StatelessWidget {
  final customerController = Get.put(CustomerController());
  final TextEditingController searchController = TextEditingController();

  CustomerList({super.key});

  DateTime? _parseDate(String dateStr) {
    try {
      // Adjust based on your stored format
      if (dateStr.contains("-")) {
        return DateTime.parse(dateStr); // e.g. 2025-09-24
      } else {
        return DateFormat("dd/MM/yyyy").parse(dateStr); // e.g. 24/09/2025
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: CustomAppBar(title: "Customer List Details"),
      body: Column(
        children: [
          /// 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
            child: InputField(
              controller: searchController,
              hintText: "Search Customer...",
              labelShow: false,
              fillColor: Colors.grey.shade100,
              hintColor: Colors.black,
              borderSideColor: Colors.black,
              labelColor: Colors.black,
              prefixIcon: AppIcons.search,
              verticalPadding: 2,
              prefixColor: Colors.black,
              onChanged: (value) => customerController.searchCustomer(value),
            ),
          ),

          /// 🧑 Customer List
          Expanded(
            child: Obx(() {
              final allCustomers = customerController.customers;
              final filtered = customerController.filteredCustomers;

              if (allCustomers.isEmpty) {
                return const Center(
                  child: Text("No customers available."),
                );
              }

              if (filtered.isEmpty) {
                return const Center(
                  child: AppText(text: "No customer found with this name."),
                );
              }

              // ✅ Sort by date (latest first)
              final sortedCustomers = filtered.toList()
                ..sort((a, b) {
                  final dateA = _parseDate(b.date) ?? DateTime(1900);
                  final dateB = _parseDate(a.date) ?? DateTime(1900);
                  return dateB.compareTo(dateA); // 🔥 Newest → Oldest
                });


              return ListView.builder(
                itemCount: sortedCustomers.length,
                itemBuilder: (context, index) {
                  final customer = sortedCustomers[index];
                  return GestureDetector(
                    onTap: ()=>Get.toNamed(AppRoutes.productScreen,arguments: customer),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            customer.name
                                .trim()
                                .split(' ')
                                .take(2)
                                .map((word) => word[0].toUpperCase())
                                .join(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: AppText(
                          text: customer.name,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: Text(
                            "📞 ${customer.phone}\n📅 ${customer.date}"),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            customerController.deleteCustomer(customer.id!);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
