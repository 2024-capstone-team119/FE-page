import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Pages/Calendar/CalendarUpcoming.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "달력",
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          Api.getPerformance_all_all(),
          Api.getPerformanceApproaching_ko(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            List<dynamic> results = snapshot.data!;
            List<Performance> performances = results[0] as List<Performance>;
            List<Performance> upcomingPerformances =
                results[1] as List<Performance>;

            // 국내 공연만 담아오기
            List<Performance> koPerformances = [];
            for (Performance performance in performances) {
              if (performance.visit == 'N') {
                koPerformances.add(performance);
              }
            }

            selectedDayController.setPerformances(koPerformances);

            return SingleChildScrollView(
              child: Column(
                children: [
                  CalendarDate(performances: koPerformances),
                  CalendarUpcoming(performances: upcomingPerformances),
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
