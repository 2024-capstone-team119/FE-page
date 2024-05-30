class User {
  final String id;
  final String email;
  final String password;
  String nickname;
  String? profileImage;
  final bool deleted;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.nickname,
    this.profileImage,
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

  User.clone(User user)
      : this(
          id: user.id,
          email: user.email,
          password: user.password,
          nickname: user.nickname,
          profileImage: user.profileImage,
          deleted: user.deleted,
        );

  void initImgFile() {
    profileImage = null;
  }
}
