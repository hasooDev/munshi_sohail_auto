import 'package:get/get.dart';

class SaleModel {
  final String customerName;
  final double totalAmount;

  SaleModel({required this.customerName, required this.totalAmount});
}

class SalesController extends GetxController {
  var salesList = <SaleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSales();
  }

  void loadSales() {
    // Example dummy data
    salesList.value = [
      SaleModel(customerName: "John Doe", totalAmount: 1200),
      SaleModel(customerName: "Jane Smith", totalAmount: 540),
    ];
  }

  void addSale(SaleModel sale) {
    salesList.add(sale);
  }

  void deleteSale(int index) {
    salesList.removeAt(index);
  }
}
