import 'package:get/get.dart';

class Category {
  int tabIdx;
  List<RxContent> content;

  Category({
    required this.tabIdx,
    this.content = const [],
  });
}

class RxContent {
  final RxInt postId;
  final RxString writer;
  final RxString title;
  final RxString content;
  final Rx<DateTime?> date;
  final RxBool isLike;
  final RxInt likeCounts;
  final RxList<Comment> comment;

  RxContent({
    required int postId,
    required String writer,
    required String title,
    required String content,
    required DateTime date,
    required bool isLike,
    required int likeCounts,
    required List<Comment> comment,
  })  : postId = postId.obs,
        writer = writer.obs,
        title = title.obs,
        content = content.obs,
        date = date.obs,
        isLike = isLike.obs,
        likeCounts = likeCounts.obs,
        comment = comment.obs;
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
}
