import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/pages/review/ReviewList.dart';
import 'package:allcon/pages/review/MyReview.dart';
import 'package:allcon/service/review/hallService.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/service/review/zoneService.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class ReviewMain extends StatefulWidget {
  final String title;
  final String hallId;

  const ReviewMain({
    super.key,
    required this.title,
    required this.hallId,
  });

  @override
  State<ReviewMain> createState() => _ReviewMainState();
}

class _ReviewMainState extends State<ReviewMain> {
  late final ReviewController _reviewController;
  String? selectedZoneId;
  String? selectedZoneName;
  List<Review> reviews = [];

  Future<void> _fetchReviews(String zoneId) async {
    try {
      List<Review> fetchedReviews = await ReviewService.getReviews(zoneId);
      setState(() {
        reviews = fetchedReviews;
      });
    } catch (error) {
      print('Error fetching reviews: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
  }

  bool recommend = false;
  bool reviewWrite = true;
  bool mine = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Hall?>(
      future: HallService.getHall(widget.hallId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Hall not found.'));
        } else {
          Hall hall = snapshot.data!;
          return GetBuilder<ReviewController>(
            init: ReviewController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Text(hall.hallImage!),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(text: '추천순'),
                                Tab(text: '최신순'),
                                Tab(text: '내 리뷰'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  reviewTab(context, true, false),
                                  reviewTab(context, false, false),
                                  reviewTab(context, false, true)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget reviewTab(BuildContext context, bool isRecommend, bool mine) {
    return FutureBuilder<List<Zone>?>(
      future: ZoneService.getZone(widget.hallId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Zones not found.'));
        } else {
          List<Zone> zones = snapshot.data!;
          List<String> zoneNames = zones.map((zone) => zone.zoneName!).toList();

          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 8.0),
                child: Column(
                  children: [
                    if (!mine)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: CustomDropdownButton(
                              items: zoneNames,
                              value: selectedZoneName!,
                              onChanged: (String? newValue) async {
                                if (newValue != null) {
                                  setState(() {
                                    selectedZoneId = newValue;
                                    selectedZoneName = zones
                                        .firstWhere(
                                            (zone) => zone.zoneId == newValue)
                                        .zoneName;
                                  });
                                  await _fetchReviews(selectedZoneId!);
                                }
                              },
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            ),
                            onPressed: () {
                              setState(() {
                                _reviewController.showWriteModalSheet(
                                    context, reviews, selectedZoneId!);
                              });
                            },
                            child: const Text(
                              '리뷰 작성하기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10.0),
                    Obx(() {
                      List<Widget> reviewWidgets = List.generate(
                        _reviewController.reviews.length,
                        (index) {
                          int reversedIndex =
                              _reviewController.reviews.length - 1 - index;

                          // goodCount가 높은 순으로 정렬합니다.
                          List<Review> sortedReviews = List.from(reviews);
                          sortedReviews.sort(
                              (a, b) => b.likeCount.compareTo(a.likeCount));

                          return mine
                              ? MyReview(
                                  index: reviews[reversedIndex].reviewId,
                                  reviewList: reviews,
                                  zone: selectedZoneName!,
                                  zoneTotal: zoneNames,
                                )
                              : isRecommend
                                  ? ReviewList(
                                      review: sortedReviews[index],
                                    )
                                  : ReviewList(
                                      review: reviews[reversedIndex],
                                    );
                        },
                      );

                      return Column(
                        children: reviewWidgets,
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
