import 'package:allcon/pages/community/controller/post_controller.dart';
import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/model/community_model.dart';
import 'package:allcon/pages/community/sub/LikeButton.dart';
import 'package:allcon/service/community/likesService.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContentListView extends StatefulWidget {
  final String category;
  final int tabIdx;
  final String searchText;
  final Future<List<Post>>? searchPosts;

  const MyContentListView({
    super.key,
    required this.category,
    required this.tabIdx,
    this.searchText = '',
    this.searchPosts,
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

  late List<Post> postsFuture;
  late List<Post>? searchPostFuture;

  Future<List<List<Post>>> fetchFuturePosts() async {
    postsFuture = await PostService.getPost(widget.category);
    searchPostFuture = await widget.searchPosts;
    return [postsFuture, searchPostFuture ?? []];
  }

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
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<Post>>>(
      future: fetchFuturePosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Post> posts = snapshot.data![0];
          List<Post>? searchPosts = snapshot.data![1];

          if (widget.searchText.isNotEmpty) {
            if (searchPosts.isNotEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: searchPosts.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = searchPosts.length - index - 1;
                      return createBox(context, searchPosts[reversedIndex]);
                    },
                  ),
                ),
              );
            } else {
              return const Preparing(
                text: '검색 결과가 없습니다.\n 다시 입력해주세요 :)',
                size: 0.15,
              );
            }
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    fetchFuturePosts();
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = posts.length - index - 1;
                      return createBox(context, posts[reversedIndex]);
                    },
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget createBox(
    BuildContext context,
    Post post,
  ) {
    DateTime dateTime =
        DateFormat('yyyy-MM-dd').parse(post.createdAt.toString());

    _postController.fetchLike(post.postId, loginUserId!);

    // 카풀 카테고리 익명 처리
    if (widget.category == '카풀') {
      anonymous = false;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(
              category: widget.category,
              tabIdx: widget.tabIdx,
              post: post,
              userId: loginUserId ?? '',
              nickname: loginUserNickname ?? '',
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
                          post.title,
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
                  Obx(
                    () => IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        _postController.isLike.value
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: _postController.isLike.value
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      onPressed: () async {
                        print('패치: ${_postController.isLike.value}');
                        _postController.fetchLike(post.postId, loginUserId!);
                        setState(() {});
                      },
                    ),
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
