import 'package:allcon/Data/Content.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  RxList<RxContent> contents = <RxContent>[].obs;
  RxInt commentCount = 0.obs; // 댓글 수 추적하는 변수

  ContentController._internal();

  factory ContentController() {
    return ContentController._internal();
  }

  // 글 목록
  void setContentList(List<RxContent> initialContents) {
    contents.assignAll(initialContents);
  }

  RxContent? getContent(int postId) {
    return contents.firstWhere((content) => content.postId.value == postId);
  }

  // 글 업로드
  void addContent(
      RxContent content, int tabIdx, List<Category> contentsamples) {
    contentsamples[tabIdx].content.add(content);
    update();
  }

  // 글 수정
  void updateContent(RxContent updatedContent) {
    final int index = contents.indexWhere(
        (content) => content.postId.value == updatedContent.postId.value);

    if (index != -1) {
      contents[index] = updatedContent;
      update();
    }
  }

  // 좋아요
  List<RxContent> getAllLikedContents() {
    return contents.where((content) => content.isLike.value == true).toList();
  }

  void toggleLike(int postId) {
    final int index =
        contents.indexWhere((content) => content.postId.value == postId);

    if (index != -1) {
      final RxContent content = contents[index];

      final int currentLike = content.likeCounts.value;
      content.isLike.value = !(content.isLike.value);
      content.likeCounts.value =
          content.isLike.value ? currentLike + 1 : currentLike - 1;

      contents[index] = content;
      update();
    }
  }

  // 댓글
  void updateComment(int postId, String commentContent) {
    final int index =
        contents.indexWhere((content) => content.postId.value == postId);

    if (index != -1) {
      final Comment comment =
          Comment(commentId: postId, commentContent: commentContent);
      contents[index].comment.add(comment);
      commentCount.value++;
      update();
    }
  }
}
