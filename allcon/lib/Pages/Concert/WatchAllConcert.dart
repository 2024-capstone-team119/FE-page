import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchAllConcert extends StatefulWidget {
  const WatchAllConcert({Key? key}) : super(key: key);

  @override
  State<WatchAllConcert> createState() => _WatchAllConcertState();
}

class _WatchAllConcertState extends State<WatchAllConcert> {
  late Future<List<Performance>> _performancesFuture;

  bool selectedOngoing = true;
  bool selectedFinished = false;
  bool selectedKorea = true;
  bool selectedOverseas = false;

  @override
  void initState() {
    super.initState();
    _performancesFuture = _fetchPerformances();
  }

  Future<List<Performance>> _fetchPerformances() async {
    try {
      List<Performance> fetchedPerformances = [];

      if (selectedOngoing &&
          !selectedFinished &&
          selectedKorea &&
          !selectedOverseas) {
        fetchedPerformances = await Api.getPerformance_ko_future();
      } else if (selectedFinished &&
          !selectedOngoing &&
          selectedKorea &&
          !selectedOverseas) {
        fetchedPerformances = await Api.getPerformance_ko_past();
      } else if (selectedOngoing &&
          !selectedFinished &&
          !selectedKorea &&
          selectedOverseas) {
        fetchedPerformances = await Api.getPerformance_visit_future();
      } else if (selectedFinished &&
          !selectedOngoing &&
          !selectedKorea &&
          selectedOverseas) {
        fetchedPerformances = await Api.getPerformance_visit_past();
      }

      return fetchedPerformances;
    } catch (error) {
      print('Error fetching performances: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '전체공연'),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Performance>>(
        future: _performancesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            List<Performance> performances = snapshot.data!;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('공연중/예정'),
                      selected: selectedOngoing,
                      selectedColor: lightMint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          // 추가된 부분: 선택된 경우에만 동작하도록 수정
                          setState(() {
                            selectedOngoing = true;
                            selectedFinished = false;
                            _performancesFuture = _fetchPerformances();
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 5),
                    ChoiceChip(
                      label: const Text('종료공연'),
                      selected: selectedFinished,
                      selectedColor: lightMint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedFinished = true;
                            selectedOngoing = false;
                            _performancesFuture = _fetchPerformances();
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 5),
                    ChoiceChip(
                      label: const Text('국내'),
                      selected: selectedKorea,
                      selectedColor: lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedKorea = true;
                            selectedOverseas = false;
                            _performancesFuture = _fetchPerformances();
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 5),
                    ChoiceChip(
                      label: const Text('내한'),
                      selected: selectedOverseas,
                      selectedColor: lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedOverseas = true;
                            selectedKorea = false;
                            _performancesFuture = _fetchPerformances();
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: performances.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        child: GestureDetector(
                          onTap: () {
                            print('항목이 클릭되었습니다: ${performances[index]}');
                            Get.to(() => PerformanceDetail(
                                  performance: performances[index],
                                ));
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              SizedBox(
                                width: 80,
                                child: Image.network(
                                  performances[index].poster ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      performances[index].name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if (performances[index].cast != null &&
                                        performances[index].cast!.isNotEmpty &&
                                        performances[index]
                                            .cast!
                                            .trim()
                                            .isNotEmpty)
                                      Text(
                                        performances[index].cast!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    const SizedBox(height: 2),
                                    if (performances[index].startDate ==
                                        performances[index].endDate)
                                      Text(
                                        '${performances[index].startDate}',
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    else
                                      Text(
                                        '${performances[index].startDate} ~ ${performances[index].endDate}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    Text(
                                      '${performances[index].place}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
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
