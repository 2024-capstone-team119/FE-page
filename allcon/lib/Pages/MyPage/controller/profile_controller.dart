import 'package:allcon/Data/User.dart';
import 'package:allcon/Pages/MyPage/controller/img_crop_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  User originMyProfile = User(
    userId: 1,
    userName: "일일구",
    email: "allcon119@inu.ac.kr",
  );
  Rx<User> myProfile = User().obs;

  @override
  void onInit() {
    myProfile(User.clone(originMyProfile));
    isEditMyProfile(false);
    super.onInit();
  }

  void toggleEditBtn() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile.value.initImgFile();
    myProfile(originMyProfile);
    toggleEditBtn();
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      my?.userName = updateName;
    });
  }

  void pickImg() async {
    if (isEditMyProfile.value) {
      File file = await ImgController.to.selectImg();
      myProfile.update((my) => my?.profileImg = file);
    }
  }
}
