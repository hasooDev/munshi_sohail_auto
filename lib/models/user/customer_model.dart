class Customermodel {
  final int? id;        // Primary key, auto increment
  final String name;
  final String phone;
  final String date;

  Customermodel({
    this.id,
    required this.name,
    required this.phone,
    required this.date,
  });

  /// Convert model to Map for SQLite
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'phone': phone,
      'date': date,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  /// Create model from Map (when fetching from DB)
  factory Customermodel.fromMap(Map<String, dynamic> map) {
    return Customermodel(
      id: map['id'] as int?,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
