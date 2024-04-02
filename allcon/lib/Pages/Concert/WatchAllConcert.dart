import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WatchAllConcert extends StatefulWidget {
  const WatchAllConcert({super.key});

  @override
  State<WatchAllConcert> createState() => _WatchAllConcertState();
}

class _WatchAllConcertState extends State<WatchAllConcert> {
  bool selectedOngoing = true;
  bool selectedFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '전체공연'),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Performance>>(
        future: Api.getPerformance_visit_future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            List<Performance> filteredPerformances = [];
            DateFormat format = DateFormat("yyyy.MM.dd");
            if (selectedOngoing) {
              filteredPerformances.addAll(snapshot.data!
                  .where((performance) => format
                      .parse(performance.endDate!)
                      .isAfter(DateTime.now()))
                  .toList());
            } else if (selectedFinished) {
              filteredPerformances.addAll(snapshot.data!
                  .where((performance) => format
                      .parse(performance.endDate!)
                      .isBefore(DateTime.now()))
                  .toList());
            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 18),
                    ChoiceChip(
                      label: Text('공연중/예정'),
                      selected: selectedOngoing,
                      avatar: Icon(CupertinoIcons.tag_circle),
                      selectedColor: lightMint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        setState(() {
                          selectedOngoing = selected;

                          selectedFinished = false;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    ChoiceChip(
                      label: Text('종료공연'),
                      selected: selectedFinished,
                      avatar: Icon(CupertinoIcons.tag_circle),
                      selectedColor: lightMint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        setState(() {
                          selectedFinished = selected;

                          selectedOngoing = false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPerformances.length,
                    itemBuilder: (context, imgIndex) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        child: GestureDetector(
                          onTap: () {
                            print(
                                '항목이 클릭되었습니다: ${filteredPerformances[imgIndex]}');
                            Get.to(() => PerformanceDetail(
                                  performance: filteredPerformances[imgIndex],
                                ));
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(
                                width: 80,
                                child: Image.network(
                                  filteredPerformances[imgIndex].poster ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredPerformances[imgIndex]
                                          .name
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if (filteredPerformances[imgIndex].cast !=
                                            null &&
                                        filteredPerformances[imgIndex]
                                            .cast!
                                            .trim()
                                            .isNotEmpty)
                                      Text(
                                        filteredPerformances[imgIndex]
                                                .cast
                                                .toString() ??
                                            'Unknown Performer',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    const SizedBox(height: 2),
                                    if (filteredPerformances[imgIndex]
                                            .startDate ==
                                        filteredPerformances[imgIndex].endDate)
                                      Text(
                                          '${filteredPerformances[imgIndex].startDate}')
                                    else
                                      Text(
                                        '${filteredPerformances[imgIndex].startDate} ~ ${filteredPerformances[imgIndex].endDate}'
                                            .toString(),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
