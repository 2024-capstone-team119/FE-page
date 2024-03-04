import 'package:allcon/Data/Content.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  RxList<Content> contents = <Content>[].obs;

  static ContentController? _instance;

  ContentController._internal(List<Content> initialContents) {
    contents.value = initialContents;
  }

  factory ContentController(List<Content> initialContents) {
    if (_instance == null) {
      _instance = ContentController._internal(initialContents);
    }
    return _instance!;
  }

  void toggleLike(int postId) {
    int index = contents.indexWhere((content) => content.postId == postId);
    if (index != -1) {
      contents[index].isLike = !contents[index].isLike;
      if (contents[index].isLike) {
        contents[index].like = (contents[index].like ?? 0) + 1;
      } else {
        contents[index].like = (contents[index].like ?? 0) - 1;
      }
      contents.refresh();
    }
  }
}
