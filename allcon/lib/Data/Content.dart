class Category {
  int tabIdx;
  List<Content> content;

  Category({
    required this.tabIdx,
    this.content = const [],
  });
}

class Content {
  final int postId;
  String title;
  String content;
  final DateTime? date;
  bool isLike;
  int like;
  List<Comment> comment;

  Content({
    required this.postId,
    required this.title,
    required this.content,
    this.date,
    this.like = 0,
    this.isLike = false,
    this.comment = const [],
  });
}

class Comment {
  int commentId;
  String commentContent;

  Comment({
    required this.commentId,
    required this.commentContent,
  });
}
