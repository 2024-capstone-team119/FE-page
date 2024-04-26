import 'package:allcon/Pages/Login/login.dart';
import 'package:allcon/Pages/MainHome/Home.dart';
import 'package:allcon/Pages/Seat/SeatLayout/Seoul/BlueSquareMasterCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('ko_KR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BlueSquareMasterCard(),
      theme: ThemeData(fontFamily: 'Pretendard'),
      themeMode: ThemeMode.system,
    );
  }
}
