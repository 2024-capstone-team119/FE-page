import 'package:allcon/Data/Sample/community_sample.dart';
import 'package:allcon/model/community_model.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  RxList<Comment> comments = <Comment>[].obs;
  RxInt commentCount = 0.obs; // 댓글 수 추적하는 변수

  ContentController._internal();

  factory ContentController() {
    return ContentController._internal();
  }

  // 글 목록
  void setContentList(List<Post> initialPosts, String category) {
    List<Post> filteredPosts =
        initialPosts.where((post) => post.category == category).toList();

    posts.assignAll(filteredPosts);
  }

  Post? getContent(String postId) {
    return posts.firstWhere((post) => post.postId == postId);
  }

  // 글 업로드
  void addContent(Post post, int tabIdx, List<Post> postsamples) {
    postsamples.add(post);
    posts.refresh();
  }

  // 글 수정
  // void updateContent(Post updatedPost, int postId) {
  //   postsamples.removeWhere((post) => post.postId == updatedPost.postId);
  //   int insertIndex = postsamples.indexWhere((post) => post.postId < postId);
  //   if (insertIndex == -1) {
  //     insertIndex = postsamples.length;
  //   }
  //   postsamples.insert(insertIndex, updatedPost);
  // }

  // 좋아요
  // List<Post> getAllLikedContents(String category) {
  //   List<Post> categoryPosts = postsamples
  //       .where((post) => post.category == category)
  //       .toList();
  //   if (categoryPosts.isEmpty) {
  //     return [];
  //   }
  //   return categoryPosts.where((post) => post.isLike == true).toList();
  // }

  // void toggleLike(int postId) {
  //   final int index =
  //       posts.indexWhere((post) => post.postId == postId);

  //   if (index != -1) {
  //     final Post post = posts[index];

  //     final int currentLike = post.likeCounts;
  //     post.isLike = !(post.isLike);
  //     post.likeCounts = post.isLike ? currentLike + 1 : currentLike - 1;

  //     posts[index] = post;
  //     update();
  //   }
  // }

  // 댓글 목록
  void setCommentList(List<Comment> initialComments, String postId) {
    List<Comment> filteredComments =
        initialComments.where((comment) => comment.postId == postId).toList();
    comments.assignAll(filteredComments);
  }

  Comment? getComment(int index) {
    return comments[index];
  }

// 댓글 추가
  void addComment(String postId, int commentId, String commentContent) {
    final Comment comment = Comment(
        postId: postId, commentId: commentId, commentContent: commentContent);

    // comments RxList에 댓글 추가
    commentsamples.add(comment);
    comments.add(comment);

    // 해당 글의 댓글 수 업데이트
    final int index = posts.indexWhere((post) => post.postId == postId);
    if (index != -1) {
      posts[index].commentCount++;
      posts.refresh();
    }
  }

  // 댓글 수정
  void updateComment(String postId, int commentId, String commentContent) {
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
