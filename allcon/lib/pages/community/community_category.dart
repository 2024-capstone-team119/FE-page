import 'package:flutter/material.dart';
import './community_articels.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class TabBarScreen extends StatefulWidget {
  final String searchText;

  const TabBarScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      child: ContainedTabBarView(
        tabs: [
          Tab(text: "자유게시판"),
          Tab(text: "공연후기"),
          Tab(text: "교환/양도"),
          Tab(text: "카풀/동행"),
        ],
        views: [
          CommuArticles(tabIndex: 0, searchText: widget.searchText),
          CommuArticles(tabIndex: 1, searchText: widget.searchText),
          CommuArticles(tabIndex: 2, searchText: widget.searchText),
          CommuArticles(tabIndex: 3, searchText: widget.searchText),
        ],
      ),
    );
  }
}
