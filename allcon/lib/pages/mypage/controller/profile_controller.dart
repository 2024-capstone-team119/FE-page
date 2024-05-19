import 'package:allcon/Data/User.dart';
import 'package:allcon/pages/mypage/controller/img_crop_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;

  User originMyProfile = User(
    userName: '',
    email: '',
  );

  Rx<User> myProfile = User(
    userName: '',
    email: '',
  ).obs;

  @override
  void onInit() {
    isEditMyProfile(false);
    myProfile(User.clone(originMyProfile));
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
