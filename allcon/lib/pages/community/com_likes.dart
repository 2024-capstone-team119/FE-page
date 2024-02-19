import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';

class MyContentLikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "좋아요 목록"),
      // Add your widgets for the community_likes screen here
    );
  }
}
