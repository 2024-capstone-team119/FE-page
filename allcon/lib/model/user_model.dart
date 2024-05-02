class Profile {
  final String username;
  final String email;

  Profile(
    this.username,
    this.email,
  );

  Profile.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'];
}
