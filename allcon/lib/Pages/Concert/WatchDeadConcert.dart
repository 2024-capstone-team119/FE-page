import 'package:allcon/Pages/Concert/PerformaceDetail.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:allcon/service/api.dart';

class WatchDeadConcert extends StatefulWidget {
  const WatchDeadConcert({super.key});

  @override
  State<WatchDeadConcert> createState() => _WatchDeadConcertState();
}

class _WatchDeadConcertState extends State<WatchDeadConcert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '마감임박 공연'),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Performance>>(
        future: Api.getPerformanceApproaching(),
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
                            width: 200,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              snapshot.data![imgIndex].cast != null &&
                                      snapshot.data![imgIndex].cast!.isNotEmpty
                                  ? Text(
                                      snapshot.data![imgIndex].name.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
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
