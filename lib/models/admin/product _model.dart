class ProductModel {
  int? id;
  String name;
  String imagePath;
  String unit;
  double pricePerUnit;
  double quantityInStock;
/*  double minStockAlert;*/
  int ? categoryId;
  int ? companyId;

  ProductModel({
    this.id,
    required this.name,
    required this.imagePath,
    required this.unit,
    required this.pricePerUnit,
    required this.quantityInStock,
    /*required this.minStockAlert,*/
    required this.categoryId,
    required this.companyId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      unit: map['unit'],
      pricePerUnit: map['pricePerUnit'],
      quantityInStock: map['quantityInStock'],
    /*  minStockAlert: map['minStockAlert'],*/
      categoryId: map['categoryId'],
      companyId: map['companyId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'unit': unit,
      'pricePerUnit': pricePerUnit,
      'quantityInStock': quantityInStock,
     /* 'minStockAlert': minStockAlert,*/
      'categoryId': categoryId,
      'companyId': companyId,
    };
  }
}
