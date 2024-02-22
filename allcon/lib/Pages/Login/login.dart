import 'package:allcon/Pages/MainHome/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyLogIn());

class MyLogIn extends StatelessWidget {
  const MyLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  double _textOpacity = 0.0;
  double _buttonOpacity = 0.0;
  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _animateTextIn();
  }

  void _animateTextIn() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _textOpacity = 1.0;
      });
      _animateButtonIn();
    });
  }

  void _animateButtonIn() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _buttonOpacity = 1.0;
        _isButtonVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 컨테이너 (그라데이션) + 로고
          Container(
            width: double.infinity,
            height: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.21, -0.98),
                end: Alignment(-0.21, 0.98),
                colors: [Color(0xFF88FFFE), Color(0xFFE57FFF)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Text(
                  "올콘",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cafe24Moyamoya',
                    fontSize: 96,
                    height: 1.0,
                  ),
                ),
                Text(
                  "ALLCON",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cafe24Moyamoya',
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 20),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: _textOpacity,
                  child: Text(
                    "콘서트 정보부터 "
                    "공연장 시야까지\n"
                    "올콘하세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 카카오톡 로그인
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: _isButtonVisible
                ? MediaQuery.of(context).size.height * 0.08
                : MediaQuery.of(context).size.height * 0.08 - 40.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _buttonOpacity,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.to(MyHome());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset(
                      'assets/login/kakao_login_large_wide.png',
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 올콘 Copyright 표시
          Align(
            alignment: Alignment(0.0, 0.95),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ⓒ 2024. (ALLCON) all rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xB27A7A7A).withOpacity(0.7),
                  fontSize: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}