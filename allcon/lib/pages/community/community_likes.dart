import 'package:flutter/material.dart';

class CommunityLikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '좋아요 목록',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      // Add your widgets for the community_likes screen here
    );
  }
}
