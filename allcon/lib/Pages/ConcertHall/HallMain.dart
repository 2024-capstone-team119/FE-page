import 'package:allcon/Pages/Seat/seat_main.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HallMain extends StatefulWidget {
  final String title;

  const HallMain({super.key, required this.title});

  @override
  State<HallMain> createState() => _HallMainState();
}

class _HallMainState extends State<HallMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: widget.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mapTab(context),
            reviewBtn(context),
            listTab(context),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }

  Widget mapTab(BuildContext context) {
    return Container(
      height: 300.0,
    );
  }

  Widget reviewBtn(BuildContext context) {
    return CustomElevatedBtn(
      text: '시야 리뷰 보러가기',
      funPageRoute: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeatMain(title: widget.title)),
        );
      },
    );
  }

  Widget listTab(BuildContext context) {
    return const Column();
  }
}
