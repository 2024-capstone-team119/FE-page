import 'package:allcon/Pages/Login/login.dart';
import 'package:allcon/Pages/MyPage/profile_controller.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);

  final ProfileController _pcon = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                    title: Text(
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
                    title: Text(
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
                    title: Text(
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
                    title: Text(
                      '회원탈퇴',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      Get.to(MyLogIn());
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
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.cyan,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => _pcon.isEditMyProfile.value ? Container() : userInfo()),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('프로필 수정'),
              onPressed: () {
                _pcon.toggleEditBtn();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget userInfo() {
  return Column(
    children: [
      Container(
        width: 120,
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://avatars.githubusercontent.com/u/115553490?v=4',
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "닉네임",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "이메일",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ],
  );
}
