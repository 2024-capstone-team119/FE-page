import 'dart:async';
import 'package:allcon/pages/login/MySignIn.dart';
import 'package:allcon/pages/login/MySignUp.dart';
import 'package:allcon/service/loginService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFirstVisit extends StatefulWidget {
  const MyFirstVisit({super.key});

  @override
  State<MyFirstVisit> createState() => _MyFirstVisitState();
}

class _MyFirstVisitState extends State<MyFirstVisit> {
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
                const SizedBox(height: 16),
                const Text(
                  "올콘",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cafe24Moyamoya',
                    fontSize: 100,
                    height: 1.0,
                  ),
                ),
                const Text(
                  "ALLCON",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cafe24Moyamoya',
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: _textOpacity,
                  child: const Text(
                    "콘서트 정보부터 "
                    "공연장 시야까지\n"
                    "올콘하세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 로그인 버튼
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 0.0,
            right: 0.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _buttonOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 로그인 버튼
                  OutlinedButton(
                    onPressed: () {
                      Get.to(MySignIn());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide.none,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.88, 50),
                    ),
                    child: Text(
                      '이메일로 로그인',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '아직 올콘러가 아니세요?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(MySignUp());
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
