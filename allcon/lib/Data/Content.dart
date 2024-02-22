class Content {
  final int postId;
  final String? boardName;
  final String? content;
  int? like;
  int? comments;
  String? title;
  String? userName;
  bool? isLike = false;
  DateTime? date;

  Content({
    required this.postId,
    this.title,
    this.boardName,
    this.like,
    this.comments,
    this.content,
    this.date,
  });
}
