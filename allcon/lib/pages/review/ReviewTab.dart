import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/MyReview.dart';
import 'package:allcon/pages/review/ReviewList.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/service/review/zoneService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReiviewTab extends StatefulWidget {
  final String placeTitle;
  final String placeId;
  final Hall hall;
  final String userId;
  final String userNickname;
  final bool isRecommend;
  final bool mine;

  const ReiviewTab({
    super.key,
    this.placeTitle = '',
    this.placeId = '',
    required this.hall,
    required this.userId,
    required this.userNickname,
    required this.isRecommend,
    required this.mine,
  });

  @override
  State<ReiviewTab> createState() => _ReiviewTabState();
}

class _ReiviewTabState extends State<ReiviewTab> {
  late final ReviewController _reviewController;

  String? selectedZoneId;
  String? selectedZoneName;

  List<Review> reviews = [];
  List<Review> recommendReviews = [];
  List<Review> myReviews = [];
  bool isLoading = true;

  // 일반 리뷰
  Future<void> _fetchReviews(String zoneId) async {
    try {
      List<Review> fetchedReviews = await ReviewService.getReviews(zoneId);

      setState(() {
        reviews = fetchedReviews;
        _reviewController.setReviewList(reviews);
      });

      // 추천순 리뷰
      List<Review> sortedReviews = List.from(reviews);
      sortedReviews.sort((a, b) => b.goodCount.compareTo(a.goodCount));

      setState(() {
        recommendReviews = sortedReviews;
        _reviewController.setRecommendReviewList(recommendReviews);
      });
    } catch (error) {
      print('Error fetching reviews: $error');
    }
  }

  // 내 리뷰
  Future<void> _fetchMyReviews() async {
    setState(() {
      _reviewController.setMyReviewList(myReviews, widget.userId);
    });
  }

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
    _fetchMyReviews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Zone>?>(
      future: ZoneService.getZone(widget.hall.hallId ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Zones not found.'));
        } else {
          List<Zone> zones = snapshot.data!;
          List<String> zoneNames = zones.map((zone) => zone.zoneName!).toList();

          if (selectedZoneName == null && zoneNames.isNotEmpty) {
            selectedZoneName = zoneNames.first;
            selectedZoneId = zones
                .firstWhere((zone) => zone.zoneName == selectedZoneName)
                .zoneId;
            _fetchReviews(selectedZoneId!);
          }

          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 8.0),
                child: Column(
                  children: [
                    if (!widget.mine)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomDropdownButton(
                              items: zoneNames,
                              value: selectedZoneName ?? '',
                              onChanged: (String? newValue) async {
                                if (newValue != null) {
                                  setState(() {
                                    selectedZoneName = newValue;
                                    selectedZoneId = zones
                                        .firstWhere(
                                            (zone) => zone.zoneName == newValue)
                                        .zoneId;
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
                            onPressed: () async {
                              final result =
                                  await _reviewController.showWriteModalSheet(
                                context,
                                selectedZoneId ?? '',
                                selectedZoneName ?? '',
                                widget.userId,
                                widget.userNickname,
                              );

                              if (result == true) {
                                await _fetchReviews(selectedZoneId!);
                              }
                            },
                            child: const Text(
                              '리뷰 작성',
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
                    widget.mine
                        ? Obx(() {
                            List<Widget> myReviewWidgets = List.generate(
                              _reviewController.myReviews.length,
                              (index) {
                                return MyReview(
                                  placeTitle: widget.placeTitle,
                                  placeId: widget.placeId,
                                  hall: widget.hall,
                                  userId: widget.userId,
                                  review: _reviewController.myReviews[index],
                                  zones: zones,
                                );
                              },
                            );
                            if (_reviewController.myReviews.isEmpty) {
                              return const Preparing(
                                text: '리뷰를 채워주세요~💖',
                                size: 0.05,
                              );
                            } else {
                              return Column(children: myReviewWidgets);
                            }
                          })
                        : Obx(() {
                            List<Widget> reviewWidgets = List.generate(
                              _reviewController.reviews.length,
                              (index) {
                                int reversedIndex =
                                    _reviewController.reviews.length -
                                        1 -
                                        index;

                                return widget.isRecommend
                                    ? ReviewList(
                                        review: _reviewController
                                            .recommendReviews[index],
                                        userId: widget.userId,
                                      )
                                    : ReviewList(
                                        review: _reviewController
                                            .reviews[reversedIndex],
                                        userId: widget.userId,
                                      );
                              },
                            );
                            if (_reviewController.reviews.isEmpty) {
                              return const Preparing(
                                text: '리뷰를 채워주세요~💖',
                                size: 0.005,
                              );
                            } else {
                              return Column(children: reviewWidgets);
                            }
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
