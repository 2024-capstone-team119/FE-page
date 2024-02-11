class Content {
  final String title;
  final String userName;
  final String date;
  bool isLike;

  Content(
      {required this.title,
      required this.userName,
      required this.date,
      this.isLike = false});
}
