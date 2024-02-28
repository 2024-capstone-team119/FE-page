import 'package:allcon/Data/User.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  Rx<User> myProfile = User(
    userId: 1,
    userName: "일일구",
    email: "allcon119@inu.ac.kr",
  ).obs;

  @override
  void onInit() {
    isEditMyProfile(false);
    super.onInit();
  }

  void toggleEditBtn() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      my?.userName = updateName;
    });
  }
}
