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

  int fetchTabIndex(String category) {
    List<String> categoryList = ['자유게시판', '후기', '카풀'];

    int tabIndex = categoryList.indexOf(category);
    return tabIndex;
  }
}
