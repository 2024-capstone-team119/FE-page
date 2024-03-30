import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Pages/Calendar/CalendarUpcoming.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'CalendarDate.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "달력",
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          Api.getPerformance(),
          Api.getPerformanceApproaching(),
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  CalendarDate(performances: performances),
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
