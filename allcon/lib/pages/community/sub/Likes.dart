import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/pages/community/controller/content_controller.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyContentLikes extends StatefulWidget {
  final ContentController contentController;
  final String initialCategory;
  final int tabIdx;

  const MyContentLikes(
      {super.key,
      required this.contentController,
      required this.initialCategory,
      required this.tabIdx});

  @override
  _MyContentLikesState createState() => _MyContentLikesState();
}

class _MyContentLikesState extends State<MyContentLikes> {
  late ContentController _contentController;
  late String _selectedCategory;
  List<Content> likedContents = [];

  @override
  void initState() {
    super.initState();
    _contentController = widget.contentController;
    _selectedCategory = widget.initialCategory;
    _updateLikedContents();
  }

  // 좋아요된 콘텐츠 목록을 업데이트하는 함수
  void _updateLikedContents() {
    likedContents = _contentController.getAllLikedContents(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: '커뮤니티',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomDropdownButton(
              items: const ['자유게시판', '후기', '카풀'],
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value.toString();
                  _updateLikedContents();
                });
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: likeList(),
    );
  }

  Widget likeList() {
    if (likedContents.isEmpty) {
      return const Preparing(
        text: "좋아요 목록이 비었습니다.\n 채워주세요 :)",
      );
    } else {
      return ListView.builder(
        itemCount: likedContents.length,
        itemBuilder: (context, index) {
          return _buildContentItem(likedContents[index]);
        },
        scrollDirection: Axis.vertical,
      );
    }
  }

  Widget _buildContentItem(Content content) {
    DateTime dateTime = content.date;
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
                          content.title,
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
                      content.isLike
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: content.isLike ? Colors.redAccent : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _contentController.toggleLike(content.postId);
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
