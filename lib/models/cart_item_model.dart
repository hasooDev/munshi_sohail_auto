class CartItemModel {
  int? id;
  final int productId;
  final String name;
  double quantity;
  final String unit;
  final double pricePerUnit;
  CartItemModel({
    this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.pricePerUnit,
  });
  double get totalPrice => quantity * pricePerUnit;
  Map<String,dynamic> toOrderItemMap(int orderId) => {
    'orderId': orderId,
    'productName': name,
    'quantity': quantity,
    'unit': unit,
    'pricePerUnit': pricePerUnit,
  };
}
