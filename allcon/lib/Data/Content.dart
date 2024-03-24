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

// 커뮤니티 글목록 관리
class ContentController extends GetxController {
  var contents = <Content>[].obs;
  void addContent(Content content) {
    contents.add(content);
  }
}
