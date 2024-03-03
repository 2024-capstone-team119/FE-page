import 'package:allcon/Pages/Community/Home.dart';
import 'package:allcon/Pages/MainHome/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/MyPage/MyPage.dart';
import '../Pages/Search/search_main.dart';
import 'package:flutter/cupertino.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MyBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Get.off(const MyPage());
            break;
          case 1:
            Get.off(const MyHome());
            break;
          case 2:
            Get.off(const Search());
            break;
          case 3:
            Get.off(const MyCommunity());
            break;
        }
      },
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      selectedItemColor: const Color(0xFF664FA4),
      unselectedItemColor: Colors.black38,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: '마이',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker_notes),
          label: '커뮤니티',
        ),
      ],
    );
  }
}
