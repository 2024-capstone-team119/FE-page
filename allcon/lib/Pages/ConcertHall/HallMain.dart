import 'package:allcon/Pages/Seat/seat_main.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Widget/Preparing.dart';
import 'package:flutter/material.dart';

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
            } else if (!snapshot.hasData) {
              return const Preparing(text: '진행 중인 공연이 없습니다.');
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
                    listTab(context, snapshot.data!),
                  ],
                ),
              );
            }
          }),
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

  Widget listTab(BuildContext context, List<Performance> performances) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '진행중/예정인 공연 (${performances.length})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey[300]),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: performances.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SizedBox(
                height: 130,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        performances[index].poster!,
                        fit: BoxFit.cover,
                        width: 100,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            performances[index].name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            '${performances[index].startDate} ~ ${performances[index].endDate}\n${performances[index].cast}',
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
