import 'package:allcon/model/user_model.dart';
import 'package:allcon/pages/mypage/controller/img_crop_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;

  Rx<User> originMyProfile = User(
    id: '',
    email: '',
    password: '',
    nickname: '',
    deleted: false,
  ).obs;

  Rx<User> myProfile = User(
    id: '',
    email: '',
    password: '',
    nickname: '',
    deleted: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('loginUserEmail');
    String? userNickname = prefs.getString('userNickname');

    if (userId != null && userNickname != null) {
      originMyProfile.value = User(
        id: userId,
        email: userEmail ?? '',
        password: '',
        nickname: userNickname,
        deleted: false,
      );
      myProfile.value = User.clone(originMyProfile.value);
    }
  }

  void toggleEditBtn() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile.value.initImgFile();
    myProfile(User.clone(originMyProfile.value));
    toggleEditBtn();
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      // my?.nickname = updateName;
    });
  }

  void pickImg() async {
    if (isEditMyProfile.value) {
      File? file = await ImgController.to.selectImg();
      if (file != null) {
        myProfile.update((my) => my?.profileImage = file.path);
      }
    }
  }
}
