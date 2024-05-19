import 'dart:html';
import 'dart:io';
import 'package:allcon/pages/mypage/sub/EditNickDailog.dart';
import 'package:allcon/pages/mypage/controller/img_crop_controller.dart';
import 'package:allcon/pages/mypage/controller/profile_controller.dart';
import 'package:allcon/service/account/profileService.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final ProfileController _pcon = Get.put(ProfileController());
  final ImgController _icon = Get.put(ImgController());

  String? loginUserId;
  String? loginUserNickname;
  String? profileImageBase64;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginUserId = prefs.getString('userId');
    String? loginUserNickname = prefs.getString('userNickname');

    if (loginUserId != null) {
      _pcon.originMyProfile.userName = loginUserNickname;
      _pcon.myProfile.value.userName = loginUserNickname;
    }
  }

  @override
  Widget build(BuildContext context) {
    return userProfile(context);
  }

  Widget userProfile(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.46,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => _pcon.isEditMyProfile.value
                  ? EditUserInfo(context, _pcon, _icon)
                  : userInfo(context, _pcon),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => _pcon.isEditMyProfile.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _pcon.rollback();
                          },
                          child: const Text(
                            '취소',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          child: const Text(
                            '완료',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            _pcon.toggleEditBtn();
                          },
                        ),
                      ],
                    )
                  : ElevatedButton(
                      child: const Text(
                        '프로필 수정',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        _pcon.toggleEditBtn();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget userInfo(BuildContext context, ProfileController pcon) {
  return Column(
    children: [
      SizedBox(
        width: 120,
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/img/avatar.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  pcon.myProfile.value.userName ?? "",
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Text(
              pcon.myProfile.value.email ?? "",
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget EditUserInfo(
    BuildContext context, ProfileController pcon, ImgController icon) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          pcon.pickImg();
        },
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: pcon.myProfile.value.profileImg == null
                      ? Image.asset(
                          'assets/img/avatar.png',
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          pcon.myProfile.value.profileImg!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            pcon.isEditMyProfile.value
                ? Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: lavenderColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          CupertinoIcons.photo_camera_solid,
                          size: 15,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ]),
        ),
      ),
      const SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Obx(
          () => Column(
            children: [
              EditNameInfo(pcon.myProfile.value.userName ?? "", () async {
                String value = await Get.dialog(EditUserName(
                  text: pcon.myProfile.value.userName,
                ));
                pcon.updateName(value);
              }),
              const SizedBox(height: 2.0),
              Text(
                pcon.myProfile.value.email ?? "",
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget EditNameInfo(String value, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(children: [
      Container(
        height: 56,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      const Positioned(
        right: 2,
        bottom: 16,
        child: Icon(
          CupertinoIcons.pencil,
          color: Colors.white,
          size: 18,
        ),
      ),
    ]),
  );
}
