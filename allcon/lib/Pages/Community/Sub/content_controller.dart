import 'package:allcon/Data/Content.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  RxMap<int, Content> contents = <int, Content>{}.obs;

  ContentController._internal(Map<int, Content> initialContents) {
    contents.value = Map.from(initialContents);
  }

  factory ContentController(Map<int, Content> initialContents) {
    return ContentController._internal(initialContents);
  }

  void toggleLike(int postId) {
    if (contents.containsKey(postId)) {
      final Content? content = contents[postId];

      if (content != null) {
        final int currentLike = content.like ?? 0;
        content.isLike = !(content.isLike ?? false);
        content.like = content.isLike ? currentLike + 1 : currentLike - 1;

        contents[postId] = content;
      }
    }
  }

  Content? getContent(int postId) {
    return contents[postId];
  }

  void updateContent(Content updatedContent) {
    contents[updatedContent.postId] = updatedContent;
  }
}
