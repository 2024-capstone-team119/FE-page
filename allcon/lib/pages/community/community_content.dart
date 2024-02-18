class Content {
  String title;
  String userName;
  String date;
  bool isLike = false;

  Content({
    required this.title,
    required this.userName,
    required this.date,
    this.isLike = false,
  });

  void likeContent() {
    this.isLike = !this.isLike;
  }
}
