class Content {
  final int postId;
  final String? boardName;
  final String? content;
  int? like;
  String? title;
  String? userName;
  bool isLike;
  DateTime? date;
  List<String>? comment;

  Content({
    required this.postId,
    this.title,
    this.boardName,
    this.like,
    this.content,
    this.date,
    this.comment,
    this.isLike = false,
  });
}
