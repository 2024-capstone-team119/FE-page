import 'package:allcon/service/community/likesService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final String userId;
  final String postId;

  const LikeButton({
    super.key,
    required this.userId,
    required this.postId,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: LikesService.isPostLiked(widget.userId, widget.postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Icon(CupertinoIcons.heart));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          bool isLike = snapshot.data!;

          return IconButton(
            iconSize: 30.0,
            icon: Icon(
              isLike ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isLike ? Colors.redAccent : Colors.grey,
            ),
            onPressed: () async {
              await LikesService.likePost(widget.postId, widget.userId);
              setState(() {});
            },
          );
        } else {
          return const Center(child: Text('No comments found'));
        }
      },
    );
  }
}
