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
  void setContentList(List<Content> initialContents, String category) {
    List<Content> filteredContents = initialContents
        .where((content) => content.category == category)
        .toList();

    contents.assignAll(filteredContents);
  }

  Content? getContent(int postId) {
    return contents.firstWhere((content) => content.postId == postId);
  }

  // 글 업로드
  void addContent(Content content, int tabIdx, List<Content> contentsamples) {
    contentsamples.add(content);
    // RxList에 변화가 있음을 감지하고 UI를 업데이트합니다.
    contents.refresh();
  }

  // 글 수정
  void updateContent(Content updatedContent, int postId) {
    // 수정된 컨텐트 제거
    contentsamples
        .removeWhere((content) => content.postId == updatedContent.postId);

    // 새로운 콘텐츠 추가할 위치 찾기
    int insertIndex =
        contentsamples.indexWhere((content) => content.postId < postId);
    if (insertIndex == -1) {
      insertIndex = contentsamples.length;
    }

    // 목표 위치에 수정된 컨텐트 추가
    contentsamples.insert(insertIndex, updatedContent);
  }

  List<Content> getAllLikedContents(String category) {
    // category와 동일한 이름을 가진 모든 Content 목록을 찾습니다.
    List<Content> categoryContents = contentsamples
        .where((content) => content.category == category)
        .toList();

    // 만약 categoryContents가 비어있다면 빈 리스트를 반환합니다.
    if (categoryContents.isEmpty) {
      return [];
    }

    // 해당 Category에서 isLike가 true인 Content 목록을 반환합니다.
    return categoryContents.where((content) => content.isLike == true).toList();
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
