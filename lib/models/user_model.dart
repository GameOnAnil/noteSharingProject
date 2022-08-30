import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String userType;

  UserModel({
    required this.name,
    required this.email,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'userType': userType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userType: map['userType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'User(name: $name, email: $email, userType: $userType)';
}
