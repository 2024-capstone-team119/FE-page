import 'package:allcon/Pages/MyPage/MyCategory.dart';
import 'package:allcon/Pages/MyPage/MyProfile.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              lightGray,
            ],
            stops: [0.0, 0.65],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyProfile(),
                const MyCategory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
