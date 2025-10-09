// lib/models/admin/consumer_data_model.dart
class ConsumerModel {
  final int? id; // SQLite primary key
  final String name;
  final String phone;
  final String shopName;
  final double totalPrice;
  final double paidAmount;
  final double remainingAmount;
  final String? billImagePath;
  final String date; // Stored as ISO8601 string

  ConsumerModel({
    this.id,
    required this.name,
    required this.phone,
    required this.shopName,
    required this.totalPrice,
    required this.paidAmount,
    required this.remainingAmount,
    this.billImagePath,
    required this.date,
  });

  // Convert object → Map (for SQLite)
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'phone': phone,
    'shopName': shopName,  // ✅ same as table
    'totalPrice': totalPrice,
    'paidAmount': paidAmount,
    'remainingAmount': remainingAmount,
    'billImagePath': billImagePath,
    'date': date,
  };
}

factory ConsumerModel.fromMap(Map<String, dynamic> map) {
  return ConsumerModel(
    id: map['id'],
    name: map['name'],
    phone: map['phone'],
    shopName: map['shopName'],  // ✅ same as table
    totalPrice: map['totalPrice'],
    paidAmount: map['paidAmount'],
    remainingAmount: map['remainingAmount'],
    billImagePath: map['billImagePath'],
    date: map['date'],
  );
}

}
