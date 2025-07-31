class UserModel {
  final int? id;
  final String email;
  final String password;
  final int role;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
