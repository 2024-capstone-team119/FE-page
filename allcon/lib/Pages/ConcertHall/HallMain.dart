import 'package:allcon/Pages/ConcertHall/PlaceInfo.dart';
import 'package:allcon/Pages/Seat/seat_main.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/model/place_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: widget.title),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          Api.getPerformanceInThisPlace(widget.id),
          Api.getPlaceById(widget.id),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else {
            List<dynamic> results = snapshot.data!;
            List<Performance> performances = results[0] as List<Performance>;
            Place placeDetail = results[1] as Place;

            return SingleChildScrollView(
              child: Column(
                children: [
                  PlaceInfo(placeDetail: placeDetail),
                  reviewBtn(context),
                  const SizedBox(height: 5.0),
                  Container(
                    height: 8.0,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                  PerformanceList(performances: performances),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }

  Widget reviewBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 8.0),
      child: CustomElevatedBtn(
        text: '시야 리뷰 보러가기',
        buttonColor: lightMint,
        textColor: Colors.white,
        icon: CupertinoIcons.eyeglasses,
        funPageRoute: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeatMain(title: widget.title)),
          );
        },
      ),
    );
  }
}
