import 'package:allcon/Pages/Calendar/CalendarMain.dart';
import 'package:allcon/Pages/MainHome/BannerConcerList.dart';
import 'package:allcon/Pages/MainHome/ConcerHallTable.dart';
import 'package:allcon/Pages/MainHome/DeadConcertCard.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: 'ALLCON',
        textFontFamily: 'Cafe24Moyamoya',
        automaticallyImplyLeading: false,
        actions: const Icon(CupertinoIcons.calendar_today),
        onActionPressed: () {
          Get.to(const Calendar());
        },
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: HomePage(),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              lightGray,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            FutureBuilder<List<dynamic>>(
              future: Future.wait([
                Api.getPerformanceNew_all(),
                Api.getPerformanceApproaching_all(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else if (snapshot.hasError) {
                  return Text('에러: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('데이터 없음');
                } else {
                  List<dynamic> data = snapshot.data!;
                  List<Performance> BannerPerformances =
                      data[0] as List<Performance>;
                  List<Performance> DeadPerformances =
                      data[1] as List<Performance>;

                  return Column(
                    children: [
                      BannerConcerList(performances: BannerPerformances),
                      const ConcertHallTable(),
                      Divider(
                        thickness: 10,
                        color: const Color(0xFFE6E6E6).withOpacity(0.4),
                      ),
                      const SizedBox(height: 15.0),
                      DeadConcertCard(performances: DeadPerformances),
                      const SizedBox(height: 30),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
