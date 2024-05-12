import 'dart:convert';
import 'package:allcon/pages/calendar/SelectConcertList.dart';
import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/concertService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/pages/calendar/CalendarUpcoming.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'CalendarDate.dart';
import './controller/selecetedDay_controller.dart';
import 'package:get/get.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final SelectedDayController selectedDayController =
      Get.put(SelectedDayController());

  late List<Performance> performancesCache = [];
  late List<Performance> upcomingPerformancesCache = [];

  Future<void> fetchPerformanceData() async {
    final cacheManager = DefaultCacheManager();
    const key = 'performance_data'; // 캐시 키

    // 캐시된 데이터 가져오기
    FileInfo? fileInfo = await cacheManager.getFileFromCache(key);

    if (fileInfo != null) {
      // 캐시된 데이터가 있으면 이를 사용
      String jsonData = await fileInfo.file.readAsString();
      List<dynamic> cachedData = jsonDecode(jsonData);
      performancesCache = (cachedData[0] as List<dynamic>)
          .map((data) => Performance.fromJson(data))
          .toList();
      upcomingPerformancesCache = (cachedData[1] as List<dynamic>)
          .map((data) => Performance.fromJson(data))
          .toList();
    } else {
      // 캐시된 데이터가 없으면 API 호출하여 데이터 가져오기
      List<Performance> performances =
          await ConcertService.getPerformance_all_all();
      List<Performance> upcomingPerformances =
          await ConcertService.getPerformanceApproaching_ko();

      // 가져온 데이터를 캐시에 저장
      await cacheManager.putFile(
        key,
        utf8.encode(jsonEncode([performances, upcomingPerformances])),
      );

      // 캐시된 데이터로 설정
      performancesCache = performances;
      upcomingPerformancesCache = upcomingPerformances;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "달력",
      ),
      body: FutureBuilder<void>(
        future: fetchPerformanceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else {
            selectedDayController.setPerformances(performancesCache);
            return SingleChildScrollView(
              child: Column(
                children: [
                  CalendarDate(),
                  SizedBox(height: 20),
                  SelectConcertList(),
                  // if (upcomingPerformancesCache.isNotEmpty)
                  //   CalendarUpcoming(performances: upcomingPerformancesCache),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }
}
