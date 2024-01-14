import 'package:flutter/material.dart';

void main() => runApp(const MyLogIn());

class MyLogIn extends StatelessWidget {
  const MyLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                Positioned(
                  // ALLCON 아이콘
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      'assets/logo/allcon-text-white.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 로그인 버튼s
          Positioned(
            bottom: 80.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // 카카오 로그인 버튼
                SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEE500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/login/kakao_icon_cloud.png',
                          width: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '카카오로 시작하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 네이버 로그인 버튼
                SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF03C75A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/login/naver_icon_white.png',
                          width: 40,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '네이버로 시작하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 올콘 Copyright 표시
          const Positioned(
            bottom: 12.0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'ⓒ 2024. (ALLCON) all rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xB27A7A7A),
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
