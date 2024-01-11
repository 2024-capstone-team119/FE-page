import 'package:flutter/material.dart';
import '../pages/mypage.dart';
import '../pages/home.dart';
import '../pages/search.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  MyBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
            break;
/*          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCommu()),
            );
            break;*/
          default:
            onTap(index);
        }
      },
      currentIndex: currentIndex,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.black38,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: '마이페이지',
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
