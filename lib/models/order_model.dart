class OrderModel {
  final int? id;
  final int customerId;
  final String date;
  final double totalAmount;
  OrderModel({
    this.id,
    required this.customerId,
    required this.date,
    required this.totalAmount,
  });
  factory OrderModel.fromMap(Map<String, dynamic> m) => OrderModel(
    id: m['id'],
    customerId: m['customerId'],
    date: m['date'],
    totalAmount: m['totalAmount'],
  );
}
