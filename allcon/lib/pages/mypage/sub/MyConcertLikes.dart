import 'package:allcon/model/performance_model.dart';
import 'package:allcon/pages/concert/PerformaceDetail.dart';
import 'package:allcon/service/concertLikesService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyConcertLikes extends StatefulWidget {
  const MyConcertLikes({super.key});

  @override
  State<MyConcertLikes> createState() => _MyConcertLikesState();
}

class _MyConcertLikesState extends State<MyConcertLikes> {
  Future<List<Performance>>? favoritePerformances;
  String? loginUserId;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
    if (loginUserId != null) {
      favoritePerformances =
          ConcertLikesService.getFavoritePerformances(loginUserId!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '관심공연 목록'),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Performance>>(
          future: favoritePerformances,
          builder: (context, snapshot) {
            if (favoritePerformances == null) {
              return const Center(child: Text('Loading...'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.isEmpty) {
              return const Preparing(text: '관심공연을\n채워주세요! 💖');
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    favoritePerformances =
                        ConcertLikesService.getFavoritePerformances(
                            loginUserId!);
                  });
                },
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, imgIndex) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      child: GestureDetector(
                        onTap: () async {
                          print('항목이 클릭되었습니다: ${snapshot.data}');
                          await Get.to(() => PerformanceDetail(
                                performance: snapshot.data![imgIndex],
                              ));
                          setState(() {
                            favoritePerformances =
                                ConcertLikesService.getFavoritePerformances(
                                    loginUserId!);
                          });
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
                                          snapshot
                                              .data![imgIndex].cast!.isNotEmpty
                                      ? Text(
                                          snapshot.data![imgIndex].name
                                              .toString(),
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
                                      snapshot.data![imgIndex].cast
                                              .toString() ??
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
                ),
              );
            }
          }),
    );
  }
}
