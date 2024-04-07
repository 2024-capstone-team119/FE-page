import 'package:allcon/Pages/Concert/WatchAllConcert.dart';
import 'package:allcon/Pages/Concert/WatchDeadConcert.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeadConcertCard extends StatefulWidget {
  final List<Performance> performances;

  const DeadConcertCard({Key? key, required this.performances})
      : super(key: key);

  @override
  State<DeadConcertCard> createState() => _DeadConcertCardState();
}

class _DeadConcertCardState extends State<DeadConcertCard> {
  @override
  Widget build(BuildContext context) {
    List<Performance> performances = widget.performances;
    List<Performance> firstList = performances.sublist(0, 3);
    List<Performance> secondList = performances.sublist(3, 6);

    return Column(
      children: [
        Container(
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 10.0),
                    _buildPerformanceList(context, firstList),
                    const SizedBox(width: 5.0),
                    _buildPerformanceList(context, secondList),
                    const SizedBox(width: 15.0),
                  ],
                ),
              ),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ),
      ],
    );
  }

  Widget _buildPerformanceList(
      BuildContext context, List<Performance> performances) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(performances.length, (index) {
          Performance performance = performances[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => PerformanceDetail(performance: performance));
              },
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black26, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          performance.poster ?? '',
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12.0),
                              Text(
                                performance.name ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              if (performance.cast != null &&
                                  performance.cast != null &&
                                  performance.cast!.trim().isNotEmpty)
                                Text(
                                  '${performance.cast}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (performance.startDate == performance.endDate)
                                Text(
                                  '${performance.startDate}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                )
                              else
                                Text(
                                  '${performance.startDate} ~ ${performance.endDate}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              Text(
                                '${performance.place}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
    );
  }
}
