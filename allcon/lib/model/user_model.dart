class User {
  final String email;
  final String password;
  final String nickname;

  User({
    required this.email,
    required this.password,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'],
    );
  }
}
