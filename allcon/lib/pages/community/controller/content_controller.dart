import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/model/community_model.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  RxList<Content> contents = <Content>[].obs;
  RxList<Comment> comments = <Comment>[].obs;
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
    contents.refresh();
  }

  // 글 수정
  void updateContent(Content updatedContent, int postId) {
    contentsamples
        .removeWhere((content) => content.postId == updatedContent.postId);
    int insertIndex =
        contentsamples.indexWhere((content) => content.postId < postId);
    if (insertIndex == -1) {
      insertIndex = contentsamples.length;
    }
    contentsamples.insert(insertIndex, updatedContent);
  }

  // 좋아요
  List<Content> getAllLikedContents(String category) {
    List<Content> categoryContents = contentsamples
        .where((content) => content.category == category)
        .toList();
    if (categoryContents.isEmpty) {
      return [];
    }
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

  // 댓글 목록
  void setCommentList(List<Comment> initialComments, int postId) {
    List<Comment> filteredComments =
        initialComments.where((comment) => comment.postId == postId).toList();
    comments.assignAll(filteredComments);
  }

  Comment? getComment(int index) {
    return comments[index];
  }

// 댓글 추가
  void addComment(int postId, int commentId, String commentContent) {
    final Comment comment = Comment(
        postId: postId, commentId: commentId, commentContent: commentContent);

    // comments RxList에 댓글 추가
    commentsamples.add(comment);
    comments.add(comment);

    // 해당 글의 댓글 수 업데이트
    final int index =
        contents.indexWhere((content) => content.postId == postId);
    if (index != -1) {
      contents[index].commentCounts++;
      contents.refresh();
    }
  }

  // 댓글 수정
  void updateComment(int postId, int commentId, String commentContent) {
    Comment updatedComment = Comment(
        postId: postId, commentId: commentId, commentContent: commentContent);

    // commentsamples 리스트에서 수정된 댓글 업데이트
    commentsamples.removeWhere((comment) => comment.commentId == commentId);
    commentsamples.insert(commentId, updatedComment);

    // comments 리스트에서도 수정된 댓글 업데이트
    int index =
        comments.indexWhere((comment) => comment.commentId == commentId);
    if (index != -1) {
      comments[index] = updatedComment;
    }

    // 화면을 다시 그리기 위해 갱신
    comments.refresh();
  }
}
