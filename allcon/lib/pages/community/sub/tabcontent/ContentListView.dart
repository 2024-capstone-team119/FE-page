import 'package:allcon/pages/community/controller/post_controller.dart';
import 'package:allcon/model/community_model.dart';
import 'package:allcon/pages/community/sub/tabcontent/ListBox.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String? loginUserId = '';
  String? loginUserNickname = '';

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
                      return ListBox(
                        post: searchPosts[reversedIndex],
                        userId: loginUserId!,
                        userNickname: loginUserNickname!,
                        category: widget.category,
                        tabIdx: widget.tabIdx,
                      );
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
                      return ListBox(
                        post: posts[reversedIndex],
                        userId: loginUserId!,
                        userNickname: loginUserNickname!,
                        category: widget.category,
                        tabIdx: widget.tabIdx,
                      );
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
}
