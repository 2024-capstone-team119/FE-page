import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/pages/login/MyLogIn.dart';
import 'package:allcon/pages/mypage/sub/MyConcertLikes.dart';
import 'package:allcon/service/account/tokenService.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/utils/jwt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  @override
  Widget build(BuildContext context) {
    final AccountController _accountController = Get.put(AccountController());

    String? loginUserId;
    void _loadUserInfo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loginUserId = prefs.getString('userId');
    }

    @override
    void initState() {
      super.initState();
      _loadUserInfo();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.deepPurple, width: 0.5),
              borderRadius: BorderRadius.circular(50),
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
                Get.to(MyConcertLikes());
              },
            ),
          ),
          SizedBox(height: 4),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.deepPurple, width: 0.5),
              borderRadius: BorderRadius.circular(50),
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
          SizedBox(height: 4),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.deepPurple, width: 0.5),
              borderRadius: BorderRadius.circular(50),
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
                _accountController.logout();
                Get.to(MyLogIn());
              },
            ),
          ),
          SizedBox(height: 4),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.deepPurple, width: 0.5),
              borderRadius: BorderRadius.circular(50),
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
                if (loginUserId != null) {
                  _accountController.deleteUser(loginUserId!).then((isDelete) {
                    if (isDelete) {
                      Get.snackbar('회원탈퇴 성공✔', "다음에 또 만나요~!");
                      Get.to(MyLogIn());
                    } else {
                      Get.snackbar('회원탈퇴 실패', "");
                      print(
                          'User ID is null. Cannot proceed with user deletion.');
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
