import 'package:allcon/model/user_model.dart';
import 'package:allcon/pages/mypage/controller/img_crop_controller.dart';
import 'package:allcon/service/account/profileService.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;

  RxString profileImage = ''.obs;

  Rx<User> originMyProfile = User(
    id: '',
    email: '',
    password: '',
    nickname: '',
    profileImage: '',
    deleted: false,
  ).obs;

  Rx<User> myProfile = User(
    id: '',
    email: '',
    password: '',
    nickname: '',
    profileImage: '',
    deleted: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // 유저 데이터 불러옴 조회
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('loginUserEmail');
    String? userNickname = prefs.getString('userNickname');

    if (userId != null && userNickname != null) {
      String? image = await ProfileService.getProfileImage(userId);
      profileImage.value = image ?? '';

      originMyProfile.value = User(
        id: userId,
        email: userEmail ?? '',
        password: '',
        nickname: userNickname,
        profileImage: image,
        deleted: false,
      );
      myProfile.value = User.clone(originMyProfile.value);
    } else {
      originMyProfile.value = User(
        id: '',
        email: '',
        password: '',
        nickname: '',
        profileImage: '',
        deleted: false,
      );
      myProfile.value = User.clone(originMyProfile.value);
    }
  }

  // 유저 닉네임 수정
  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null &&
        myProfile.value.nickname != originMyProfile.value.nickname) {
      bool success =
          await ProfileService.updateNickname(userId, myProfile.value.nickname);
      if (success) {
        await prefs.setString('userNickname', myProfile.value.nickname);
        originMyProfile.value.nickname = myProfile.value.nickname;
        print(myProfile.value.nickname);
      } else {
        // 닉네임 변경 실패 처리
        print('Failed to update nickname');
      }
    }
  }

  Future<void> updateProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null &&
        myProfile.value.profileImage != originMyProfile.value.profileImage) {
      String? imageUrl = await ProfileService.uploadProfileImage(
          userId, File(myProfile.value.profileImage!));
      if (imageUrl != null) {
        originMyProfile.value.profileImage = myProfile.value.profileImage;
        profileImage.value = imageUrl;
        print('Profile image updated');
      } else {
        print('Failed to update profile image');
      }
    }
  }

  void toggleEditBtn() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile(User.clone(originMyProfile.value));
    toggleEditBtn();
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      my?.nickname = updateName;
    });
  }

  void pickImg() async {
    if (isEditMyProfile.value) {
      File? file = await ImgController.to.selectImg();
      if (file != null) {
        myProfile.update((my) => my?.profileImage = file.path);
        profileImage.value = file.path;
      }
    }
  }
}
