import 'dart:io';

class User {
  final userId;
  String? userName;
  final email;
  File? profileImg;

  User({
    this.userId,
    this.userName,
    this.email,
    this.profileImg,
  });
}
