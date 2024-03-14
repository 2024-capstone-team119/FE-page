import 'package:allcon/Pages/MyPage/MyProfile.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
      appBar: MyAppBar(
        text: '마이페이지',
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
      ),
      body: MyProfile(),
    );
  }
}
