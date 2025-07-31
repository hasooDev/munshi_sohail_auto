class CustomerModel {
  final int? id;
  final String name;
  final String phone;
  final String? address;
  CustomerModel({
    this.id,
    required this.name,
    required this.phone,
    this.address,
  });
  factory CustomerModel.fromMap(Map<String, dynamic> m) => CustomerModel(
    id: m['id'],
    name: m['name'],
    phone: m['phone'],
    address: m['address'],
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'address': address,
  };
}
