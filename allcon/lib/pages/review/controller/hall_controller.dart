import 'package:allcon/model/review_model.dart';
import 'package:get/get.dart';

class HallController extends GetxController {
  HallController._internal();

  factory HallController() {
    return HallController._internal();
  }

  Rx<Hall> bascirHall = Hall(
    hallId: '',
    placeId: '',
    hallImage: '',
  ).obs;
}
