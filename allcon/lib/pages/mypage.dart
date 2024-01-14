import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: Center(
        child: Text(
          '이곳에 마이페이지 컨텐츠를 추가하세요.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
