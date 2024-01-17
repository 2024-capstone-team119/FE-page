import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('마이페이지'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(child: MyPages()),
    );
  }
}

class MyPages extends StatefulWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  _MyPagesState createState() => _MyPagesState();
}

class _MyPagesState extends State<MyPages> {
  String _nickname = '일일구';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            color: Colors.redAccent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                    backgroundColor: Colors.white,
                    radius: 45.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      Text(
                        '닉네임',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(width: 50.0),
                      Flexible(
                        child: Text(
                          _nickname,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _showNicknameInputDialog(context);
                        },
                        child: Text(
                          '수정',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      Text(
                        '이메일',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(width: 50.0),
                      Text(
                        'allcon911@inu.ac.kr',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.17),
                      TextButton(onPressed: () {}, child: Text('회원탈퇴'))
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.grey[850],
              ),
              title: Text(
                '관심 공연 목록',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                print('관심 공연 목록 is clicked');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            child: ListTile(
              leading: Icon(
                Icons.help_outline_rounded,
                color: Colors.grey[850],
              ),
              title: Text(
                '문의사항',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                print('문의사항 is clicked');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            child: ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.grey[850],
              ),
              title: Text(
                '로그아웃',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                print('로그아웃 is clicked');
              },
            ),
          ),
        ],
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
