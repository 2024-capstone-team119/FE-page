import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:allcon/Pages/Concert/WatchAllConcert.dart';
import 'package:allcon/Pages/Concert/WatchDeadConcert.dart';
import 'package:allcon/Pages/Concert/concertinfo.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DeadConcertList extends StatefulWidget {
  const DeadConcertList({super.key});

  @override
  State<DeadConcertList> createState() => _DeadConcertListState();
}

class _DeadConcertListState extends State<DeadConcertList> {
  List<Concert> deadConcert = deadConcertSample;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.lightBlueAccent,
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

          /*Swiper(
            itemBuilder: (BuildContext context, int index) {
              return
            },
            itemCount: deadConcertSample.length,
            viewportFraction: 0.8,
            scale: 0.9,
          ),*/
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(deadConcertSample.length, (index) {
                Concert concert = deadConcertSample[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        const ConcertInfo(),
                        arguments: concert,
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15.0),
                      //   // side:
                      //   //     const BorderSide(color: Colors.black87, width: 0.1),
                      // ),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              concert.imgUrl ?? "",
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 12.0),
                                  Text(
                                    concert.title ?? "",
                                    style: const TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3.0),
                                  Text(
                                    '공연일 : ${DateFormat('yyyy-MM-dd').format(concert.date!)} ${DateFormat('HH:mm').format(concert.date!)}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    '장소 : ${concert.place}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    '관람 연령 : 만 ${concert.age} 세 이상',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    '관람 시간 : 총 ${concert.time} 분',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    print('마감공연 버튼 클릭 성공');
                    Get.to(WatchDeadConcert());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(width: 0.25),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '마감공연 보기',
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
                    Get.to(WatchAllConcert());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(width: 0.25),
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
