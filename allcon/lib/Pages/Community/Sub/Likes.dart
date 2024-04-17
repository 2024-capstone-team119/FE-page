import 'package:allcon/Data/Content.dart';
import 'package:allcon/Pages/Community/Sub/GetPost.dart';
import 'package:allcon/Pages/Community/controller/content_controller.dart';
import 'package:allcon/Widget/Preparing.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyContentLikes extends StatefulWidget {
  final ContentController contentController;

  const MyContentLikes({
    super.key,
    required this.contentController,
  });

  @override
  _MyContentLikesState createState() => _MyContentLikesState();
}

class _MyContentLikesState extends State<MyContentLikes> {
  late ContentController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = widget.contentController;
  }

  @override
  Widget build(BuildContext context) {
    List<RxContent> likedContents = _contentController.getAllLikedContents();

    if (likedContents.isEmpty) {
      return const Scaffold(
        appBar: MyAppBar(text: '커뮤니티'),
        body: Preparing(
          text: "좋아요 목록이 비었습니다.\n 채워주세요 :)",
        ),
      );
    }

    return Scaffold(
      appBar: const MyAppBar(text: '커뮤니티'),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: likedContents.length,
        itemBuilder: (context, index) {
          return _buildContentItem(likedContents[index]);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _buildContentItem(RxContent content) {
    DateTime dateTime = content.date.value ?? DateTime.now();
    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(
              content: content,
              contentController: _contentController,
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
                          content.title.value,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(dateTime),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              DateFormat('HH:mm').format(dateTime),
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
                              "${content.likeCounts}",
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
                              "${content.comment.length}",
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
                      content.isLike.value
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color:
                          content.isLike.value ? Colors.redAccent : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _contentController.toggleLike(content.postId.value);
                      });
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
