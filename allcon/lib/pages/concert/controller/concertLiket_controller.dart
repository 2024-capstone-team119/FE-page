import 'package:get/get.dart';

class concertLikedController extends GetxController {
  bool _isLike = false;
  bool get likes => _isLike;

  void getLiked() {
    _isLike = !_isLike;
    update();
  }
}
