import 'package:allcon/Pages/Community/Sub/Likes.dart';
import 'package:allcon/Pages/Community/Sub/Post.dart';
import 'package:allcon/Pages/Community/Sub/Search.dart';
import 'package:allcon/Pages/Community/Sub/TabContent/ContentListView.dart';
import 'package:allcon/Pages/Community/controller/content_controller.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCommunity extends StatefulWidget {
  final int initialTabIndex;
  const MyCommunity({super.key, this.initialTabIndex = 0});

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  String searchText = '';
  late final ContentController _contentController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialTabIndex);
    _contentController = ContentController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: "커뮤니티",
        automaticallyImplyLeading: false,
        actions: const Padding(
          padding: EdgeInsets.only(right: 8.0, top: 5.0),
          child: Icon(
            CupertinoIcons.heart_circle,
            size: 30.0,
          ),
        ),
        onActionPressed: () {
          Get.to(MyContentLikes(contentController: _contentController));
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 130.0,
            height: 45.0,
            child: FloatingActionButton(
              backgroundColor: lavenderColor,
              onPressed: () {
                Get.to(MyContentWrite(
                  initialCategory:
                      getTabName(_tabController.index), // 현재 선택된 탭의 이름 전달
                ));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.pencil_outline,
                    size: 16.0,
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    '글쓰기',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
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

  String getTabName(int index) {
    switch (index) {
      case 0:
        return "자유게시판";
      case 1:
        return "후기";
      case 2:
        return "교환/양도";
      case 3:
        return "카풀/동행";
      default:
        return "";
    }
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
