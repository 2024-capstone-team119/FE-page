import 'package:allcon/model/community_model.dart';
import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/service/community/likesService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListBox extends StatefulWidget {
  final Post post;
  final String userId;
  final String userNickname;
  final String category;
  final int tabIdx;

  const ListBox({
    super.key,
    required this.post,
    required this.userId,
    required this.userNickname,
    required this.category,
    required this.tabIdx,
  });

  @override
  State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
  late bool anonymous = true;

  late int likesCount;
  late bool isLike = false;

  @override
  void initState() {
    super.initState();
    likesCount = widget.post.likesCount;
    _fetchLike();
  }

  Future<void> _fetchLike() async {
    bool result =
        await LikesService.isPostLiked(widget.userId, widget.post.postId);
    setState(() {
      isLike = result;
    });
  }

  Future<void> _toggleLike() async {
    await LikesService.likePost(widget.post.postId, widget.userId);
    setState(() {
      if (isLike) {
        isLike = false;
        likesCount--;
      } else {
        isLike = true;
        likesCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateFormat('yyyy-MM-dd').parse(widget.post.createdAt.toString());

    // 카풀 카테고리 익명 처리
    if (widget.category == '카풀') {
      anonymous = false;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(
              category: widget.category,
              tabIdx: widget.tabIdx,
              post: widget.post,
              userId: widget.userId,
              nickname: widget.userNickname,
              likeCount: likesCount,
              anonymous: anonymous,
              route: 0,
            ));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              height: 80.0,
              child: Row(
                children: [
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text(
                              anonymous ? '익명' : widget.post.nickname,
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              '|',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              DateFormat('yyyy-MM-dd').format(dateTime),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red[300],
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "$likesCount",
                              style: TextStyle(
                                color: Colors.red[300],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${widget.post.commentCount}",
                              style: const TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(
                      isLike ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      color: isLike ? Colors.redAccent : Colors.grey,
                    ),
                    onPressed: () async {
                      _toggleLike();
                    },
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          Container(height: 1.0, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
