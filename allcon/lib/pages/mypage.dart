import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마이페이지'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: MyPages());
  }
}

class MyPages extends StatelessWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'),
            backgroundColor: Colors.white,
          ),
          accountName: Text('일일구'),
          accountEmail: Text('911@email.com'),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.grey[850],
          ),
          title: Text('관심 공연 목록'),
          onTap: () {
            print('관심 공연 목록 is clicked');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.help_outline_rounded,
            color: Colors.grey[850],
          ),
          title: Text('문의사항'),
          onTap: () {
            print('문의사항 is clicked');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout_outlined,
            color: Colors.grey[850],
          ),
          title: Text('로그아웃'),
          onTap: () {
            print('로그아웃 is clicked');
          },
        ),
      ],
    );
  }
}
