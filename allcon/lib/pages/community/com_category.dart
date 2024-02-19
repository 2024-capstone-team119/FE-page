import 'package:flutter/material.dart';
import './com_contentList.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class MyContentCategory extends StatefulWidget {
  final String searchText;

  const MyContentCategory({Key? key, required this.searchText})
      : super(key: key);

  @override
  State<MyContentCategory> createState() => _ContentCategoryState();
}

class _ContentCategoryState extends State<MyContentCategory> {
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
          MyContentList(tabIndex: 0, searchText: widget.searchText),
          MyContentList(tabIndex: 1, searchText: widget.searchText),
          MyContentList(tabIndex: 2, searchText: widget.searchText),
          MyContentList(tabIndex: 3, searchText: widget.searchText),
        ],
      ),
    );
  }
}
