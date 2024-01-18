import 'package:flutter/material.dart';
import './community_articels.dart';

class TabBarScreen extends StatefulWidget {
  final String searchText;

  const TabBarScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 350),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _tabBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                CommuArticles(tabIndex: 0, searchText: widget.searchText),
                CommuArticles(tabIndex: 1, searchText: widget.searchText),
                CommuArticles(tabIndex: 2, searchText: widget.searchText),
                CommuArticles(tabIndex: 3, searchText: widget.searchText),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: tabController,
      tabs: const [
        Tab(text: "자유게시판"),
        Tab(text: "공연후기"),
        Tab(text: "교환/양도"),
        Tab(text: "카풀/동행"),
      ],
    );
  }
}
