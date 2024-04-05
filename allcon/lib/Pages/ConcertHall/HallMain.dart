import 'package:allcon/Pages/Seat/seat_main.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:flutter/material.dart';
import 'PerformanceList.dart';

class HallMain extends StatefulWidget {
  final String title;
  final String id;

  const HallMain({super.key, required this.title, required this.id});

  @override
  State<HallMain> createState() => _HallMainState();
}

class _HallMainState extends State<HallMain> {
  late final Future<List<Performance>> performances =
      Api.getPerformanceInThisPlace(widget.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: widget.title),
      body: FutureBuilder<List<Performance>>(
        future: performances,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  mapTab(context),
                  reviewBtn(context),
                  const SizedBox(height: 5.0),
                  Container(
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                  ),
                  PerformanceList(performances: snapshot.data!),
                ],
              ),
            );
          }
        },
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
}
