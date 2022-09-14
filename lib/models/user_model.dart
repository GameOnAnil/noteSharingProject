class UserModel {
  final String id;
  final String name;
  final String email;
  final String userType;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'userType': userType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userType: map['userType'] ?? '',
    );
  }
}
