import 'package:sohail_auto/models/admin/product_purchase_model.dart';

class CustomerModel {
  final int id;
  final String name;
  final String phone;
  final List<ProductPurchase> purchases;
  double totalPaid;
  double totalRemaining;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.purchases,
    required this.totalPaid,
    required this.totalRemaining,
  });

  double get totalAmount =>
      purchases.fold(0, (sum, item) => sum + (item.price * item.quantity));
}