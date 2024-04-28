class Profile {
  final String username;
  final String email;
  final String gender;
  final String age;
  final String name;

  Profile(
    this.username,
    this.email,
    this.gender,
    this.age,
    this.name,
  );

  Profile.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        gender = json['gender'],
        age = json['age'],
        name = json['name'];
}
