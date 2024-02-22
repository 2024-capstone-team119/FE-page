import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';

class MyContentLikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(text: "좋아요 목록"),
    );
  }
}
