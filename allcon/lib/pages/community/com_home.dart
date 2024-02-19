import 'package:allcon/pages/community/com_likes.dart';
import 'package:allcon/pages/community/com_write.dart';
import 'package:flutter/material.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../community/com_search.dart';
import '../community/com_category.dart';

class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key}) : super(key: key);

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
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
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 3,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyContentLikes()));
            },
            child: Icon(Icons.favorite),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyContentWrite()));
            },
            child: Icon(Icons.edit),
          ),
        ],
      ),
      body: Community(),
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
          Container(
            child: MyContentSearch(
              onSearchTextChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            // color: Colors.redAccent,
          ),
          Container(
            child: MyContentCategory(searchText: searchText),
            // color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
