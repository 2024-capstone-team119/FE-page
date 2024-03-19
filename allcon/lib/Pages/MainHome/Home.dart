import 'package:allcon/Pages/Calendar/calendar_main.dart';
import 'package:allcon/Pages/MainHome/BannerConcerList.dart';
import 'package:allcon/Pages/MainHome/ConcerHallTable.dart';
import 'package:allcon/Pages/MainHome/DeadConcertList.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/copyRight_ALLCON.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Pages/ConcertHall/hall_search.dart';
import 'package:get/get.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key});

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            lightGray,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const BannerConcerList(),
            ConcertHallTable(),
            Divider(thickness: 10, color: Color(0xFFE6E6E6).withOpacity(0.4)),
            SizedBox(height: 15.0),
            const DeadConcertList(),
            SizedBox(height: 50),
            copyRightAllCon(),
          ],
        ),
      ),
    );
  }
}
