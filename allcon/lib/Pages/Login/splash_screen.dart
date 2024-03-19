import 'package:allcon/Pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const LogIn(),
        ));
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
                    fontSize: 96,
                    height: 1.0,
                  ),
                ),
                const Text(
                  "ALLCON",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cafe24Moyamoya',
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "콘서트 정보부터 "
                  "공연장 시야까지\n"
                  "올콘하세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.0),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
