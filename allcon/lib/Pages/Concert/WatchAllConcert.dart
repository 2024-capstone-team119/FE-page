import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchAllConcert extends StatefulWidget {
  const WatchAllConcert({super.key});

  @override
  State<WatchAllConcert> createState() => _WatchAllConcertState();
}

class _WatchAllConcertState extends State<WatchAllConcert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '전체공연'),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Performance>>(
        future: Api.getPerformance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('데이터 없음');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, imgIndex) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  child: GestureDetector(
                    onTap: () {
                      print('항목이 클릭되었습니다: ${snapshot.data}');
                      Get.to(() => PerformanceDetail(
                            performance: snapshot.data![imgIndex],
                          ));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Image.network(
                            snapshot.data![imgIndex].poster ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![imgIndex].name.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (snapshot.data != null &&
                                  snapshot.data![imgIndex].cast != null &&
                                  snapshot.data![imgIndex].cast!
                                      .trim()
                                      .isNotEmpty)
                                Text(
                                  snapshot.data![imgIndex].cast.toString() ??
                                      'Unknown Performer',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              const SizedBox(height: 2),
                              Text(
                                '${snapshot.data![imgIndex].startDate} ~ ${snapshot.data![imgIndex].endDate}'
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
