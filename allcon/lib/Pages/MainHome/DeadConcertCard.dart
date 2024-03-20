import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:allcon/Pages/Concert/concertinfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DeadConcertCard extends StatelessWidget {
  const DeadConcertCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 공연 정보 리스트
    List<Concert> deadConcerts = deadConcertSample;

    // 첫 번째 리스트의 공연 정보
    List<Concert> firstList = deadConcerts.sublist(0, 3);

    // 두 번째 리스트의 공연 정보
    List<Concert> secondList = deadConcerts.sublist(3, 6);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 10.0),
          _buildConcertList(context, firstList),
          _buildConcertList(context, secondList),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }

  Widget _buildConcertList(BuildContext context, List<Concert> concerts) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(concerts.length, (index) {
            Concert concert = concerts[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
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
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.78,
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
