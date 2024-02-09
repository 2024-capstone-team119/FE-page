import 'package:allcon/pages/community/community_likes.dart';
import 'package:allcon/pages/community/community_write.dart';
import 'package:flutter/material.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../community/community_search.dart';
import '../community/community_category.dart';

class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key}) : super(key: key);

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '커뮤니티',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommunityLikes()));
            },
            child: Icon(Icons.favorite),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommunityWrite()));
            },
            child: Icon(Icons.edit),
          ),
        ],
      ),
      body: Community(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  String searchText = ''; // 검색어 상태 추가

  @override
  Widget build(BuildContext context) {
    double tableVarHeight = kToolbarHeight;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Search(
              onSearchTextChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            height: 50,
          ),
          SizedBox(
            child: TabBarScreen(searchText: searchText), // 검색어 전달
            height: MediaQuery.of(context).size.height,
          ),
          // copyRightAllCon(),
        ],
      ),
    );
  }
}

Widget copyRightAllCon() {
  return Container(
    padding: const EdgeInsets.all(15.0),
    child: const Text(
      'ⓒ 2024. (ALLCON) all rights reserved.',
      style: TextStyle(
        fontSize: 10.0,
        color: Colors.grey,
      ),
    ),
  );
}
