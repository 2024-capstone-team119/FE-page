import 'package:allcon/Pages/Community/Home.dart';
import 'package:allcon/Pages/MainHome/Home.dart';
import 'package:flutter/material.dart';
import '../Pages/MyPage/MyPage.dart';
import '../Pages/Search/search_main.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MyBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHome()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Search()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyCommunity()),
            );
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
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
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
