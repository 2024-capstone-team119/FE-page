import 'package:allcon/model/community_model.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;

  PostController._internal();

  factory PostController() {
    return PostController._internal();
  }

  void fetchPosts(String category) async {
    try {
      final fetchedPosts = await PostService.getPost(category);
      posts.assignAll(fetchedPosts);
    } catch (e) {
      print('PostController 에러');
    }
  }

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
}
