import 'package:allcon/pages/login/login.dart';
import 'package:allcon/pages/mypage/sub/MyConcertLikes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';

class MyCategory extends StatelessWidget {
  const MyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 6.0),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
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
                Get.to(const MyConcertLikes());
              },
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
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
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.escape,
                color: Colors.grey[850],
              ),
              title: const Text(
                '로그아웃',
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                logOutWithNaver();
              },
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.delete_simple,
                color: Colors.grey[850],
              ),
              title: const Text(
                '회원탈퇴',
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                widthDrawNaver();
              },
            ),
          ),
        ],
      ),
    );
  }
}

//  회원 로그아웃
Future<void> logOutWithNaver() async {
  try {
    FlutterNaverLogin.logOut().then((value) => {
          print("Naver Logout is successful"),
          Get.to(const MyLogIn()),
        });
  } catch (error) {
    print('네이버 유저 로그아웃 실패');
    print(error);
  }
}

// 회원 탈퇴
Future<void> widthDrawNaver() async {
  try {
    FlutterNaverLogin.logOutAndDeleteToken().then((value) => {
          print("네이버 탈퇴 is successful"),
          Get.to(const MyLogIn()),
        });
  } catch (error) {
    print('네이버 유저 탈퇴 실패');
    print(error);
  }
}
