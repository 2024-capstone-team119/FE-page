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
    return const Scaffold(
      appBar: MyAppBar(
        text: "달력",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 500.0,
              child: CalendarDate(),
            ),
            SizedBox(
              height: 300.0,
              child: CalendarUpcoming(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(currentIndex: 1),
    );
  }
}
