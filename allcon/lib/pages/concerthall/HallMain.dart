import 'package:allcon/pages/concerthall/PlaceInfo.dart';
import 'package:allcon/pages/review/ReviewMain.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/model/place_model.dart';
import 'package:allcon/service/concertService.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/utils/Loading.dart';
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
          ConcertService.getPerformanceInThisPlace(widget.id),
          ConcertService.getPlaceById(widget.id),
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
                  PlaceInfo(
                    placeDetail: placeDetail,
                  ),
                  const SizedBox(height: 5.0),
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
      padding: const EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 5.0),
      child: CustomElevatedBtn(
        text: '시야 리뷰 보러가기',
        buttonColor: lightMint,
        textColor: Colors.white,
        icon: CupertinoIcons.eyeglasses,
        funPageRoute: () {
          print(widget.id);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReviewMain(
                      title: widget.title,
                      hallId: widget.id,
                    )),
          );
        },
      ),
    );
  }
}
