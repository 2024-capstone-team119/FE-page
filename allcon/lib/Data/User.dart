import 'dart:io';

class User {
  final int? userId;
  String? userName;
  final String? email;
  File? profileImg;

  User({
    this.userId,
    this.userName,
    this.email,
    this.profileImg,
  });

  User.clone(User user)
      : this(
          userId: user.userId,
          userName: user.userName,
          email: user.email,
        );
}
