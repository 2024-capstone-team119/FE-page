import 'package:allcon/Data/Content.dart';
import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/Pages/Community/Sub/GetPost.dart';
import 'package:allcon/Pages/Community/Sub/Likes.dart';
import 'package:allcon/Pages/Community/Sub/Post.dart';
import 'package:allcon/Pages/Community/Sub/Search.dart';
import 'package:allcon/Pages/Community/Sub/TabContent/ContentListView.dart';
import 'package:allcon/Pages/Community/controller/content_controller.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key}) : super(key: key);

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  String searchText = '';
  late final ContentController _contentController; // ContentController 추가

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _contentController = ContentController(); // ContentController 초기화
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "커뮤니티",
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.to(MyContentLikes(contentController: _contentController));
            },
            child: Icon(Icons.favorite),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () {
              Get.to(MyContentWrite());
            },
            child: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: MyContentSearch(
              onSearch: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: tabBar(
              context,
              _tabController,
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBar(BuildContext context, TabController tabController) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: const <Widget>[
              Tab(text: "자유게시판"),
              Tab(text: "후기"),
              Tab(text: "교환/양도"),
              Tab(text: "카풀/동행"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                MyContentListView(
                  tabIdx: 0,
                  contentController: _contentController,
                  searchText: searchText,
                ),
                MyContentListView(
                  tabIdx: 1,
                  contentController: _contentController,
                  searchText: searchText,
                ),
                MyContentListView(
                  tabIdx: 2,
                  contentController: _contentController,
                  searchText: searchText,
                ),
                MyContentListView(
                  tabIdx: 3,
                  contentController: _contentController,
                  searchText: searchText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
