class CompanyModel {
  final int? id;
  final String name;
  final String? imagePath;

  CompanyModel({this.id, required this.name, this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
    );
  }
}
//
class Company {
  final int? id;
  final String name;
  final String? imageUrl;

  Company({this.id, required this.name, this.imageUrl});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
  };

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json['id'],
    name: json['name'],
    imageUrl: json['image_url'],
  );
}
