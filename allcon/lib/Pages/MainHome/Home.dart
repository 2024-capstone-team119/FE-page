import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:allcon/Pages/Calendar/calendar_main.dart';
import 'package:allcon/Pages/Concert/concertinfo.dart' as concertinfo;
import 'package:allcon/Pages/MainHome/BannerConcerList.dart';
import 'package:allcon/Pages/MainHome/DeadConcertList.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/copyRight_ALLCON.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:allcon/Pages/ConcertHall/hall_search.dart';
import 'package:allcon/Data/Concert.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      body: SafeArea(
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      /*Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.redAccent,
              Colors.lime,
            ],
          ),
        ),
      ),*/
      Column(
        children: <Widget>[
          BannerConcerList(),
          ConcertHallCateogory(context),
          DeadConcertList(),
          copyRightAllCon(),
        ],
      ),
    ]);
  }
}

Widget ConcertHallCateogory(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            '공연장',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Table(
          border: TableBorder.all(),
          children: [
            buildRow(context, ['서울', '경기도/인천', '강원도']),
            buildRow(context, ['충청도', '경상도', '전라도']),
          ],
        ),
      ],
    ),
  );
}

TableRow buildRow(BuildContext context, List<String> cells) {
  return TableRow(
    decoration: BoxDecoration(color: Colors.white),
    children: cells
        .map(
          (cell) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HallSearch(
                    initialTitle: cell,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        )
        .toList(),
  );
}
