import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/pages/login/MyLogIn.dart';
import 'package:allcon/pages/mypage/sub/ConfirmDelete.dart';
import 'package:allcon/pages/mypage/sub/MyConcertLikes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.put(AccountController());

    String? loginUserId;
    Future<void> loadUserInfo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loginUserId = prefs.getString('userId');
    }

    @override
    void initState() {
      super.initState();
      loadUserInfo();
    }

    Future<void> launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
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
                Get.to(const MyConcertLikes());
              },
            ),
          ),
          const SizedBox(height: 4),
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
                launchURL('https://open.kakao.com/o/srZYQSsg');
              },
            ),
          ),
          const SizedBox(height: 4),
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
                accountController.logout();
                Get.offAll(const MyLogIn());
              },
            ),
          ),
          const SizedBox(height: 4),
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
              onTap: () async {
                await showDeleteDialog(context, accountController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
