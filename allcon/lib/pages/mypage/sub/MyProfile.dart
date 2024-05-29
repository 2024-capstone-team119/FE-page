import 'dart:io';
import 'package:allcon/pages/mypage/controller/profile_controller.dart';
import 'package:allcon/pages/mypage/sub/EditNickDailog.dart';
import 'package:allcon/pages/mypage/controller/img_crop_controller.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final ProfileController _pcon = Get.put((ProfileController()));
  final ImgController _icon = Get.put(ImgController());

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
                          onPressed: () async {
                            bool isNicknameChanged =
                                _pcon.myProfile.value.nickname !=
                                    _pcon.originMyProfile.value.nickname;
                            bool isProfileImageChanged =
                                _pcon.myProfile.value.profileImage !=
                                    _pcon.originMyProfile.value.profileImage;
                            if (isNicknameChanged) {
                              await _pcon.updateProfile();
                            }

                            if (isProfileImageChanged) {
                              await _pcon.updateProfileImage();
                            }

                            if (isNicknameChanged || isProfileImageChanged) {
                              await _pcon.loadUserData();
                            }

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
          child: Obx(() {
            if (pcon.profileImage.value.isEmpty) {
              return Image.asset(
                'assets/img/avatar.png',
                fit: BoxFit.cover,
              );
            } else {
              return Image.network(
                pcon.profileImage.value,
                fit: BoxFit.cover,
              );
            }
          }),
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
                  pcon.myProfile.value.nickname,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Text(
              pcon.myProfile.value.email,
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
                  child: Obx(() {
                    if (pcon.profileImage.value.isEmpty) {
                      return Image.asset(
                        'assets/img/avatar.png',
                        fit: BoxFit.cover,
                      );
                    } else {
                      if (pcon.profileImage.value.startsWith('http')) {
                        return Image.network(
                          pcon.profileImage.value,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Image.file(
                          File(pcon.profileImage.value),
                          fit: BoxFit.cover,
                        );
                      }
                    }
                  }),
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
              EditNameInfo(pcon.myProfile.value.nickname, () async {
                String value = await Get.dialog(EditUserName(
                  text: pcon.myProfile.value.nickname,
                ));
                pcon.updateName(value);
              }),
              const SizedBox(height: 2.0),
              Text(
                pcon.myProfile.value.email,
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
      Center(
        child: Container(
          height: 56,
          width: 200,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.4, color: Colors.black26),
            ),
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
        right: 52,
        bottom: 24,
        child: Icon(
          CupertinoIcons.wand_stars_inverse,
          color: Colors.black,
          size: 18,
        ),
      ),
    ]),
  );
}
