// 커뮤니티 글 모델

class Content {
  final String category;
  final int postId;
  final String writer;
  final String title;
  final String content;
  final DateTime date;
  late bool isLike;
  late int likeCounts;
  final List<Comment> comment;

  Content({
    required this.category,
    required this.postId,
    required this.writer,
    required this.title,
    required this.content,
    required this.date,
    required this.isLike,
    required this.likeCounts,
    required this.comment,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      category: json['category'],
      postId: json['postId'],
      writer: json['writer'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      isLike: json['isLike'],
      likeCounts: json['likeCounts'],
      comment: (json['comment'] as List<dynamic>)
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList(),
    );
  }
}

class Comment {
  int commentId;
  String commentWriter;
  String commentContent;

  Comment({
    required this.commentId,
    this.commentWriter = '댓익명',
    required this.commentContent,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      commentContent: json['commentContent'],
    );
  }
}
