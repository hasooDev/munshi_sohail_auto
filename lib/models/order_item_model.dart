class OrderItemModel {
  final int? id;
  final int orderId;
  final String productName;
  final double quantity;
  final String unit;
  final double pricePerUnit;
  OrderItemModel({
    this.id,
    required this.orderId,
    required this.productName,
    required this.quantity,
    required this.unit,
    required this.pricePerUnit,
  });
  factory OrderItemModel.fromMap(Map<String, dynamic> m) => OrderItemModel(
    id: m['id'],
    orderId: m['orderId'],
    productName: m['productName'],
    quantity: m['quantity'],
    unit: m['unit'],
    pricePerUnit: m['pricePerUnit'],
  );
}
