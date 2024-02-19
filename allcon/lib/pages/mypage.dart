import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _nickname = '일일구';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(text: '마이페이지'),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.56,
                color: Colors.cyan,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                        backgroundColor: Colors.white,
                        radius: 60.0,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              _nickname,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'allcon911@inu.ac.kr',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('닉네임 수정'),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('회원탈퇴'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.favorite,
                        color: Colors.grey[850],
                      ),
                      title: Text(
                        '관심 공연 목록',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onTap: () {
                        print('관심 공연 목록 is clicked');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help_outline_rounded,
                        color: Colors.grey[850],
                      ),
                      title: Text(
                        '문의사항',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onTap: () {
                        print('문의사항 is clicked');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.grey[850],
                      ),
                      title: Text(
                        '로그아웃',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onTap: () {
                        print('로그아웃 is clicked');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 닉네임 수정 다이얼로그 표시
  Future<void> _showNicknameInputDialog(BuildContext context) async {
    TextEditingController _nicknameController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('닉네임 수정'),
          content: TextField(
            controller: _nicknameController,
            maxLength: 8,
            decoration: InputDecoration(hintText: '새로운 닉네임 입력'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                String newNickname = _nicknameController.text.trim();

                if (newNickname.isNotEmpty) {
                  setState(() {
                    _nickname = newNickname;
                  });
                }

                Navigator.of(context).pop();
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }
}
