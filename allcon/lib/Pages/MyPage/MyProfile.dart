import 'package:allcon/Pages/Login/login.dart';
import 'package:allcon/Pages/MyPage/edit_userName.dart';
import 'package:allcon/Pages/MyPage/controller/img_crop_controller.dart';
import 'package:allcon/Pages/MyPage/controller/profile_controller.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});

  final ProfileController _pcon = Get.put(ProfileController());
  final ImgController _icon = Get.put(ImgController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: lavenderColor,
        ),
        child: Column(
          children: [
            userProfile(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.grey[850],
                    ),
                    title: const Text(
                      '관심 공연 목록',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      print('관심 공연 목록 is clicked');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.info_circle,
                      color: Colors.grey[850],
                    ),
                    title: const Text(
                      '문의사항',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      print('문의사항 is clicked');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.escape,
                      color: Colors.grey[850],
                    ),
                    title: const Text(
                      '로그아웃',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      print('로그아웃 is clicked');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.delete_simple,
                      color: Colors.grey[850],
                    ),
                    title: const Text(
                      '회원탈퇴',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      Get.to(const MyLogIn());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userProfile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.52,
      decoration: BoxDecoration(
        color: lightlavenderColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
                          style: const ButtonStyle(),
                          onPressed: () {
                            _pcon.rollback();
                          },
                          child: const Text('취소'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('완료'),
                          onPressed: () {
                            _pcon.toggleEditBtn();
                          },
                        ),
                      ],
                    )
                  : ElevatedButton(
                      child: const Text('프로필 수정'),
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
            'assets/logo/allcon_icon.png',
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Text(
              pcon.myProfile.value.email ?? "",
              style: const TextStyle(
                fontSize: 15.0,
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
                          'assets/logo/allcon_icon.png',
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
                          color: Colors.white,
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
                  fontSize: 15.0,
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
        height: 50,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.6, color: Colors.white),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24.0,
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
