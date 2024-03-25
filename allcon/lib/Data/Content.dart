import 'package:get/get.dart';

class Content {
  final int postId;
  String title;
  String content;
  final DateTime? date;
  bool isLike;
  int like;
  List<String> comment;

  Content({
    required this.postId,
    this.title = '제목없음',
    this.like = 0,
    this.content = '내용없음',
    this.date,
    this.comment = const [],
    this.isLike = false,
  });
}
