import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/const/res/app_icons.dart';
import 'package:sohail_auto/const/res/app_strings.dart';
import 'package:sohail_auto/features/controller/customer_controller.dart';
import 'package:sohail_auto/widgets/input_field.dart';
import 'package:sohail_auto/widgets/text_action.dart';

import '../../../const/res/app_color.dart';
import 'app_text.dart';

class AddCustomerBottomSheet extends StatefulWidget {
  const AddCustomerBottomSheet({super.key});

  @override
  State<AddCustomerBottomSheet> createState() => _AddCustomerBottomSheetState();
}

class _AddCustomerBottomSheetState extends State<AddCustomerBottomSheet> {
  final customerController = Get.put(CustomerController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  /// Pick a date

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              Future<void> pickDate() async {
                final DateTime? pickedDate = await showDatePicker(

                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  setState(() {
                    dateController.text =
                        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  });
                }
              }

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// --- Title ---
                      AppText(
                        text: "Add Customer",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      const SizedBox(height: 16),

                      /// --- Name Field ---
                      InputField(
                        controller: nameController,
                        hintText: "Enter customer name",
                        label: "Name",
                        labelColor: AppColors.black,
                        fillColor: Colors.grey.shade100,
                        hintColor: Colors.black54,
                        borderSideColor: AppColors.black,
                        prefixColor: Colors.black,
                        prefixIcon: AppIcons.user,
                        keyboardAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),

                      /// --- Phone Field ---
                      InputField(
                        controller: phoneController,
                        hintText: "Enter phone number",
                        label: "Phone",
                        labelColor: AppColors.black,
                        fillColor: Colors.grey.shade100,
                        hintColor: Colors.black54,
                        borderSideColor: AppColors.black,
                        keyboardType: TextInputType.phone,
                        prefixIcon: AppIcons.call,
                        prefixColor: Colors.black,
                        keyboardAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),

                      /// --- Date Field ---
                      GestureDetector(
                        onTap: pickDate,
                        child: AbsorbPointer(
                          child: InputField(
                            controller: dateController,
                            hintText: "Select date",
                            label: "Date",
                            labelColor: AppColors.black,
                            fillColor: Colors.grey.shade100,
                            hintColor: Colors.black54,
                            borderSideColor: AppColors.black,
                            prefixIcon: AppIcons
                                .calender, // <-- make sure you have a calendar icon
                            prefixColor: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// --- Save Button ---
                      SizedBox(
                        width: double.infinity,
                        child: TextAction(
                          onPressed: () {
                            // TODO: save customer in SQLite here using DatabaseHelper
                            // Get.back(); // close sheet
                            customerController.validateAndSubmitCustomer(
                              context: context,
                              nameController: nameController,
                              phoneController: phoneController,
                              dateController: dateController,
                            );
                          },
                          text: AppStrings.save,
                          backgroundColor: Colors.black,
                          verticalPadding: 12,
                          iconShow: false,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
