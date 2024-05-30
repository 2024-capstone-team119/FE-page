import 'package:allcon/model/community_model.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  RxBool isLike = false.obs;

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
}
