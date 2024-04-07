import 'package:allcon/Pages/Concert/WatchAllConcert.dart';
import 'package:allcon/Pages/Concert/WatchDeadConcert.dart';
import 'package:allcon/Pages/MainHome/DeadConcertCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';

class DeadConcertList extends StatefulWidget {
  const DeadConcertList({Key? key});

  @override
  State<DeadConcertList> createState() => _DeadConcertListState();
}

class _DeadConcertListState extends State<DeadConcertList> {
  late List<Performance> performances;

  @override
  void initState() {
    super.initState();
    _fetchDeadConcerts();
  }

  Future<void> _fetchDeadConcerts() async {
    try {
      performances = await Api.getPerformanceApproaching_all();
      setState(() {}); // Refresh UI after data fetch
    } catch (error) {
      print('Error fetching dead concerts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '마감임박',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          if (performances.isNotEmpty)
            DeadConcertCard(performances: performances),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    print('마감공연 버튼 클릭 성공');
                    Get.to(const WatchDeadConcert());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.black26, width: 0.5),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '마감임박 공연',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(width: 5.0),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 13.0,
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    print('전체공연 버튼 클릭 성공');
                    Get.to(const WatchAllConcert());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.black26, width: 0.5),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '공연 전체보기',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(width: 5.0),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 13.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
