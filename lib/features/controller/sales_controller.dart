import 'package:get/get.dart';
import 'package:sohail_auto/models/admin/sales_model.dart';

class SalesController extends GetxController {
  var salesList = <Sale>[].obs;

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  /// Update calendar selection
  void updateSelectedDay(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
    update();
  }

  /// Get sales by type: day, week, year
  List<Sale> getSalesByType(String type) {
    final now = DateTime.now();

    switch (type) {
      case "day":
        return salesList
            .where((sale) =>
                sale.date.year == selectedDay.value.year &&
                sale.date.month == selectedDay.value.month &&
                sale.date.day == selectedDay.value.day)
            .toList();

      case "week":
        final startOfWeek =
            now.subtract(Duration(days: now.weekday - 1)); // Monday
        final endOfWeek =
            now.add(Duration(days: 7 - now.weekday)); // Sunday

        return salesList
            .where((sale) =>
                sale.date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
                sale.date.isBefore(endOfWeek.add(const Duration(days: 1))))
            .toList();

      case "year":
        return salesList
            .where((sale) => sale.date.year == now.year)
            .toList();

      default:
        return salesList;
    }
  }

  /// Mock add sale (you would replace with SQLite insert)
  void addSale(String customerName, double amount) {
    salesList.add(
      Sale(
        customerName: customerName,
        totalAmount: amount,
        date: DateTime.now(),
      ),
    );
  }
}