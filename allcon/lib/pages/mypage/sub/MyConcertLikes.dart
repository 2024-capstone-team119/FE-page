import 'package:allcon/model/concertLikes_model.dart';
import 'package:allcon/pages/concert/PerformaceDetail.dart';
import 'package:allcon/service/concertLikesService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:allcon/service/concertService.dart';

class MyConcertLikes extends StatefulWidget {
  const MyConcertLikes({super.key});

  @override
  State<MyConcertLikes> createState() => _MyConcertLikesState();
}

class _MyConcertLikesState extends State<MyConcertLikes> {
  final userId = 'userId';
  final client = http.Client();
  final concertLikesService = ConcertLikesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '관심공연 목록'),
      backgroundColor: Colors.white,
      body: FutureBuilder<ConcertLikes?>(
          future: concertLikesService.fetchConcertLikes(client, userId),
          builder: (context, snapshot) {
            return Container();
            /*ListView.builder(
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
                              if (snapshot.data![imgIndex].startDate ==
                                  snapshot.data![imgIndex].endDate)
                                Text(
                                  '${snapshot.data![imgIndex].startDate}'
                                      .toString(),
                                )
                              else
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
            );*/
          }),
    );
  }
}
