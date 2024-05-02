import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/model/community_model.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  RxList<Content> contents = <Content>[].obs;
  RxInt commentCount = 0.obs; // 댓글 수 추적하는 변수

  ContentController._internal();

  factory ContentController() {
    return ContentController._internal();
  }

  // 글 목록
  void setContentList(List<Content> initialContents) {
    contents.assignAll(initialContents);
  }

  Content? getContent(int postId) {
    return contents.firstWhere((content) => content.postId == postId);
  }

  // 글 업로드
  void addContent(Content content, int tabIdx, List<Category> contentsamples) {
    contentsamples[tabIdx].content.add(content);
    // RxList에 변화가 있음을 감지하고 UI를 업데이트합니다.
    contents.refresh();
  }

  // 글 수정
  void updateContent(Content updatedContent, int selectedCategoryIndex,
      String? originCategory) {
    // 옮길 카테고리의 컨텐트 리스트
    List<Content> targetCategoryContents =
        contentsamples[selectedCategoryIndex].content;

    // 수정된 컨텐트의 목표 위치
    int targetIndex = 0;
    for (int i = 0; i < targetCategoryContents.length; i++) {
      if (targetCategoryContents[i].postId > updatedContent.postId) {
        targetIndex = i;
        break;
      }
    }

    // 수정된 컨텐트 제거
    int oldCategoryIndex = contentsamples
        .indexWhere((category) => category.name == originCategory);
    contentsamples[oldCategoryIndex]
        .content
        .removeWhere((content) => content.postId == updatedContent.postId);

    // 목표 위치에 수정된 컨텐트 추가
    contentsamples[selectedCategoryIndex].content.insert(
          targetIndex,
          updatedContent,
        );

    // 글 업데이트
    final int index = contents
        .indexWhere((content) => content.postId == updatedContent.postId);

    if (index != -1) {
      contents[index] = updatedContent;
      update();
    }
  }

  List<Content> getAllLikedContents(int tabIdx) {
    Category? category = contentsamples
        .firstWhereOrNull((category) => category.tabIdx == tabIdx);
    // 해당 Category에서 isLike가 true인 Content 목록을 반환합니다.
    if (category != null) {
      return category.content
          .where((content) => content.isLike == true)
          .toList();
    }
    return [];
  }

  void toggleLike(int postId) {
    final int index =
        contents.indexWhere((content) => content.postId == postId);

    if (index != -1) {
      final Content content = contents[index];

      final int currentLike = content.likeCounts;
      content.isLike = !(content.isLike);
      content.likeCounts = content.isLike ? currentLike + 1 : currentLike - 1;

      contents[index] = content;
      update();
    }
  }

  // 댓글
  void updateComment(int postId, String commentContent) {
    final int index =
        contents.indexWhere((content) => content.postId == postId);

    if (index != -1) {
      final Comment comment =
          Comment(commentId: postId, commentContent: commentContent);
      contents[index].comment.add(comment);
      commentCount.value++;
      // RxList에 변화가 있음을 감지하고 UI를 업데이트합니다.
      contents.refresh();
    }
  }
}
