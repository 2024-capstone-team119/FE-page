import 'package:allcon/Pages/MyPage/MyPage.dart';
import 'package:allcon/pages/home/Home.dart';
import 'package:allcon/pages/login/MyLogIn.dart';
import 'package:allcon/pages/mypage/sub/MyProfile.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

// 지도 초기화하기
Future<void> initializeMap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'lwmtx4vq4u', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

void main() async {
  final client = http.Client();
  await initializeDateFormatting('ko_KR', null);
  await initializeMap();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogIn(),
      theme: ThemeData(fontFamily: 'Pretendard'),
      themeMode: ThemeMode.system,
    );
  }
}
