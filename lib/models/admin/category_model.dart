class CategoryModel {
  final int? id;
  final String name;
  final String? imagePath;
  final int companyId;

  CategoryModel({
    this.id,
    required this.name,
    this.imagePath,
    required this.companyId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'companyId': companyId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      companyId: map['companyId'],
    );
  }
}
