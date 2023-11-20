import 'dart:convert';

class PasswordModel {
  String name;

  String password;

  DateTime createdAt;

  PasswordModel({
    required this.name,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'password': password,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      name: map['name'] as String,
      password: map['password'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordModel.fromJson(String source) =>
      PasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
