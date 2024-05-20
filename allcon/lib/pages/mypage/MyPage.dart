import 'package:allcon/pages/mypage/sub/MyCategory.dart';
import 'package:allcon/pages/mypage/sub/MyProfile.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        text: '마이페이지',
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyProfile(),
                SizedBox(height: 20),
                const MyCategory(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
