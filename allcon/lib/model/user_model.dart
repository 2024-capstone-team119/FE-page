class User {
  final String id;
  final String email;
  final String password;
  final String nickname;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'],
    );
  }
}
