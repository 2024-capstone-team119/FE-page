import 'package:allcon/model/performance_model.dart';
import 'package:allcon/pages/concert/PerformaceDetail.dart';
import 'package:allcon/pages/concert/concert_likes_controller.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyConcertLikes extends StatelessWidget {
  const MyConcertLikes({super.key});

  @override
  Widget build(BuildContext context) {
    final ConcertLikesController _concertLikesController =
        Get.put(ConcertLikesController());

    return Scaffold(
      appBar: const MyAppBar(text: '관심공연 목록'),
      backgroundColor: Colors.white,
      body: Obx(() {
        RxList<Performance> favoritePerformances =
            _concertLikesController.favoritePerformances;
        if (favoritePerformances.isEmpty) {
          return Preparing(text: '관심공연을\n채워주세요! 💖');
        } else {
          return ListView.builder(
            itemCount: favoritePerformances.length,
            itemBuilder: (context, imgIndex) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => PerformanceDetail(
                          performance: favoritePerformances[imgIndex],
                        ));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Image.network(
                          favoritePerformances[imgIndex].poster ?? '',
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favoritePerformances[imgIndex].name ?? 'Unknown',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              favoritePerformances[imgIndex].cast ?? 'Unknown',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${favoritePerformances[imgIndex].startDate} ~ ${favoritePerformances[imgIndex].endDate}',
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
      }),
    );
  }
}
