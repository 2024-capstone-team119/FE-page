import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: const Center(
        child: Text(
          '이곳에 마이페이지 컨텐츠를 추가하세요.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
