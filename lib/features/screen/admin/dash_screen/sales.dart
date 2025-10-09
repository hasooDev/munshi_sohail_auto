import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../const/res/app_color.dart';
import '../../../../models/user/sales_controller.dart';
import '../../../../widgets/app_text.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> with SingleTickerProviderStateMixin {
  final salesController = Get.put(SalesController());
  late TabController _tabController;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedDay = _focusedDay;
  }

  Widget _buildSalesList(String type) {
    final sales = salesController.salesList;

    if (sales.isEmpty) {
      return const Center(
        child: AppText(
          text: "No Sales Found",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.c979797,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final sale = sales[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.c5669ff.withOpacity(0.1),
              child: const Icon(Icons.shopping_cart, color: AppColors.c5669ff),
            ),
            title: AppText(
              text: "Customer: ${sale.customerName}",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            subtitle: AppText(
              text: "Total: ₹${sale.totalAmount}",
              fontSize: 14,
              color: AppColors.c979797,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.c5669ff),
            onTap: () {
              // TODO: open sale details
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Sales Report"),
      body: Column(
        children: [
          // Tabs
          Container(
            color: AppColors.c5669ff.withOpacity(0.1),
            child: TabBar(
              
              controller: _tabController,
              indicatorColor: AppColors.c5669ff,
              labelColor: AppColors.c5669ff,
              unselectedLabelColor: AppColors.c979797,
              tabs: const [
                Tab(text: "One-Day"),
                Tab(text: "Weekly"),
                Tab(text: "Yearly"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // One-Day Sales with Calendar
                Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: AppColors.softRed,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.c5669ff,
                          shape: BoxShape.circle,
                        ),
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        // TODO: fetch sales by selectedDay
                      },
                    ),
                    Expanded(child: _buildSalesList("day")),
                  ],
                ),

                // Weekly Sales
                _buildSalesList("week"),

                // Yearly Sales
                _buildSalesList("year"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
