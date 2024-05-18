import 'dart:ffi';

class User {
  final String id;
  final String email;
  final String password;
  final String nickname;
  final String profileImage;
  final Bool deleted;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.nickname,
    required this.profileImage,
    required this.deleted,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'],
      profileImage: json['profileImage'],
      deleted: json['deleted'],
    );
  }
}
