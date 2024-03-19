import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:allcon/Pages/Concert/concertinfo.dart';
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
      color: Colors.lightBlueAccent,
      child: Column(
        children: [
          Text(
            '마감임박',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.black87, width: 0.3),
                      ),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              bottomLeft: Radius.circular(25.0),
                            ),
                            child: Image.network(
                              concert.imgUrl ?? "",
                              width: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 12.0),
                                  Text(
                                    concert.title ?? "",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '공연일 : ${DateFormat('yyyy-MM-dd').format(concert.date!)} ${DateFormat('HH:mm').format(concert.date!)}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    '장소 : ${concert.place}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    '관람 연령 : 만 ${concert.age} 세 이상',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    '관람 시간 : 총 ${concert.time} 분',
                                    style: TextStyle(fontSize: 14.0),
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
        ],
      ),
    );
  }
}
