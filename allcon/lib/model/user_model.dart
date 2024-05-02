class User {
  final String email;
  final String password;
  final String nickname;

  User(
    this.email,
    this.password,
    this.nickname,
  );

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        nickname = json['nickname'];
}
