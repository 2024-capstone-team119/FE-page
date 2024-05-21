import 'package:allcon/pages/home/Home.dart';
import 'package:allcon/pages/login/MyLogIn.dart';
import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

// 지도 초기화하기
Future<void> initializeMap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'lwmtx4vq4u', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플러터 프레임워크 초기화
  await initializeDateFormatting('ko_KR', null);
  await initializeMap();

  Get.put(AccountController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(fontFamily: 'Pretendard'),
      themeMode: ThemeMode.system,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSplashScreen(
            splash: Image.asset('assets/img/splash-icon.gif'),
            splashIconSize: 680,
            nextScreen: const RedirectPage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'ALLCON',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.deepPurple,
                  fontFamily: 'Cafe24Moyamoya',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RedirectPage extends StatelessWidget {
  const RedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AccountController>().isLogin.value;
    return isLoggedIn ? const MyHome() : const MyLogIn();
  }
}
