import 'package:allcon/pages/community/controller/post_controller.dart';
import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/model/community_model.dart';
import 'package:allcon/service/community/likesService.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContentListView extends StatefulWidget {
  final String category;
  final int tabIdx;
  final String searchText;

  const MyContentListView({
    super.key,
    required this.category,
    required this.tabIdx,
    this.searchText = '',
  });

  @override
  State<MyContentListView> createState() => _MyContentListViewState();
}

class _MyContentListViewState extends State<MyContentListView> {
  final PostController _postController = PostController();
  String? loginUserId;
  String? loginUserNickname;
  late bool anonymous = true;
  final bool likeToDetail = false;

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
    loginUserNickname = prefs.getString('userNickname');
  }

  @override
  void initState() {
    super.initState();
    _postController.fetchPosts(widget.category);
    _loadInfo();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: PostService.getPost(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Post> posts = snapshot.data!;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final reversedIndex = posts.length - index - 1;
                  return _buildContentItem(
                      context, posts[reversedIndex], reversedIndex);
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildContentItem(BuildContext context, Post post, int index) {
    final lowercaseSearchText = widget.searchText.toLowerCase();
    final lowercaseContent = post.text.toLowerCase();

    if (widget.searchText.isNotEmpty &&
        !lowercaseContent.contains(lowercaseSearchText)) {
      return Container();
    } else {
      return createBox(context, post);
    }
  }

  Widget createBox(
    BuildContext context,
    Post post,
  ) {
    DateTime dateTime =
        DateFormat('yyyy-MM-dd').parse(post.createdAt.toString());

    // 카풀 카테고리 익명 처리
    if (widget.category == '카풀') {
      anonymous = false;
    }

    return FutureBuilder<bool>(
      future: LikesService.isPostLiked(loginUserId!, post.postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          bool isLike = snapshot.data!;

          return GestureDetector(
            onTap: () {
              Get.to(() => MyContentDetail(
                    category: widget.category,
                    tabIdx: widget.tabIdx,
                    post: post,
                    userId: loginUserId ?? '',
                    nickname: loginUserNickname ?? '',
                    anonymous: anonymous,
                    likeToDetail: false,
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  Text(
                                    anonymous ? '익명' : post.nickname,
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
                          icon: Icon(
                            isLike
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: isLike ? Colors.redAccent : Colors.grey,
                          ),
                          onPressed: () async {
                            await LikesService.likePost(
                                post.postId, loginUserId ?? '');
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
