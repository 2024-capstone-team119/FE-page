import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/service/community/myContentService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContent extends StatefulWidget {
  const MyContent({super.key});

  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  String? loginUserId;
  String? userNickname;
  Future<List<Post>>? futurePosts;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginUserId = prefs.getString('userId');
      userNickname = prefs.getString('userNickname');
      if (loginUserId != null) {
        futurePosts = MyContentService.getMyPost(loginUserId!);
      } else {
        futurePosts = Future.error('User ID is null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: '내 게시글',
      ),
      backgroundColor: Colors.white,
      body: futurePosts == null
          ? Container(child: const Text('Fetching Error'))
          : FutureBuilder<List<Post>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Preparing(
                    text: "작성한 게시글이 없습니다\n 마구마구 작성해서\n 올콜러들과 공유해주세요! 😚",
                  );
                } else {
                  List<Post> posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      Post post = posts[index];
                      return _buildContentItem(post);
                    },
                  );
                }
              },
            ),
    );
  }

  Widget _buildContentItem(Post post) {
    DateTime dateTime = post.createdAt;
    late bool isAnonymous;

    if (post.category == '후기') {
      isAnonymous = false;
    } else {
      isAnonymous = true;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(
              post: post,
              userId: loginUserId!,
              category: '',
              nickname: userNickname!,
              tabIdx: 0,
              anonymous: isAnonymous,
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
                        Text(
                          DateFormat('yyyy-MM-dd').format(dateTime),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${post.likesCount}",
                              style: const TextStyle(
                                color: Colors.red,
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
