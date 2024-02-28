import 'dart:io';

class User {
  int userId;
  String userName;
  String email;
  File? profileImg;

  User({
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImg,
  });
}
