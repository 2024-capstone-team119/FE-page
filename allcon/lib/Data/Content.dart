class Content {
  final String? boardName;
  final String? content;
  int? like;
  int? comments;
  String? title;
  String? userName;
  bool? isLike = false;
  DateTime? date;

  Content({
    this.title,
    this.boardName,
    this.like,
    this.comments,
    this.content,
    this.date,
  });
}
