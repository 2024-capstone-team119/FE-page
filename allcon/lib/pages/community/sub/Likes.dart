import 'package:allcon/pages/community/Home.dart';
import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/service/community/likesService.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyContentLikes extends StatefulWidget {
  final String initialCategory;
  final int tabIdx;
  final String userId;
  final String nickname;

  const MyContentLikes({
    super.key,
    required this.initialCategory,
    required this.tabIdx,
    required this.userId,
    required this.nickname,
  });

  @override
  _MyContentLikesState createState() => _MyContentLikesState();
}

class _MyContentLikesState extends State<MyContentLikes> {
  late String _selectedCategory;
  late Future<List<Map<String, dynamic>>> _likedListFuture;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _likedListFuture = LikesService.getLikedPosts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: '커뮤니티',
        onLeadingPressed: () {
          Get.to(() => MyCommunity(initialTabIndex: widget.tabIdx));
        },
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
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _likedListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Post> posts = [];

          for (int i = 0; i < snapshot.data!.length; i++) {
            Map<String, dynamic> allLikedPosts = snapshot.data![i];
            Post post = allLikedPosts['post'];
            if (post.category == _selectedCategory) {
              posts.add(post);
            }
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return _buildContentItem(posts[index]);
            },
            scrollDirection: Axis.vertical,
          );
        } else {
          return const Preparing(
            text: "좋아요 목록이 비었습니다.\n 채워주세요 :)",
          );
        }
      },
    );
  }

  Widget _buildContentItem(Post post) {
    DateTime dateTime = post.createdAt;
    return FutureBuilder<bool>(
      future: LikesService.isPostLiked(widget.userId, post.postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              Get.to(() => MyContentDetail(
                    post: post,
                    userId: widget.userId,
                    nickname: widget.nickname,
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
                                post.title,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
                                    "${post.likesCount}",
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
                                    "${post.commentCount}",
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
                          icon: const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.redAccent,
                          ),
                          onPressed: () async {
                            await LikesService.likePost(
                                post.postId, widget.userId);
                            _likedListFuture =
                                LikesService.getLikedPosts(widget.userId);
                            setState(() {});
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
        } else {
          return const Center(child: Text('No comments found'));
        }
      },
    );
  }
}
