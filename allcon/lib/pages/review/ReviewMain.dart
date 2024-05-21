import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/pages/review/ReviewList.dart';
import 'package:allcon/pages/review/MyReview.dart';
import 'package:allcon/service/review/hallService.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/service/review/zoneService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String? loginUserId;
  String? loginUserNickname;

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginUserId = prefs.getString('userId');
      loginUserNickname = prefs.getString('userNickname');
    });
  }

  Future<void> _fetchReviews(String zoneId) async {
    try {
      List<Review> fetchedReviews = await ReviewService.getReviews(zoneId);
      setState(() {
        reviews = fetchedReviews;
        _reviewController.setReviewList(reviews);
      });
    } catch (error) {
      print('Error fetching reviews: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
    _loadInfo();
  }

  bool recommend = false;
  bool reviewWrite = true;
  bool mine = false;

  Widget reviewTab(
      BuildContext context, Hall hall, bool isRecommend, bool mine) {
    return FutureBuilder<List<Zone>?>(
      future: ZoneService.getZone(hall.hallId ?? ''),
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
                    if (!mine)
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
                                loginUserId ?? '',
                                loginUserNickname ?? '',
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
                    Obx(() {
                      List<Widget> reviewWidgets = List.generate(
                        _reviewController.reviews.length,
                        (index) {
                          int reversedIndex =
                              _reviewController.reviews.length - 1 - index;

                          // goodCount가 높은 순으로 정렬합니다.
                          List<Review> sortedReviews = List.from(reviews);
                          sortedReviews.sort(
                              (a, b) => b.goodCount.compareTo(a.goodCount));

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
                                      userId: loginUserId ?? '',
                                    )
                                  : ReviewList(
                                      review: reviews[reversedIndex],
                                      userId: loginUserId ?? '',
                                    );
                        },
                      );
                      if (_reviewController.reviews.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              const Text(
                                'O',
                                style: TextStyle(
                                  fontSize: 120.0,
                                  fontFamily: 'Cafe24Moyamoya',
                                  color: Color(0xFFff66a1),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                '리뷰를 채워주세요~💖',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Hall?>(
        future: HallService.getHall(widget.hallId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
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
                    title: Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  backgroundColor: const Color(0xFFF6F4F5),
                  body: Stack(
                    children: [
                      const Positioned(
                          bottom: 60.0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              '끝까지 내려주셨군요!\n이걸 본 당신은 올콘입니다 🍀 ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          )),
                      Positioned.fill(
                        child: SnappingSheet(
                          snappingPositions: const [
                            SnappingPosition.factor(
                              positionFactor: 0.52,
                              snappingCurve: Curves.easeOutExpo,
                              snappingDuration: Duration(milliseconds: 500),
                              grabbingContentOffset: GrabbingContentOffset.top,
                            ),
                            SnappingPosition.factor(
                              positionFactor: 1.0,
                              snappingCurve: Curves.easeOutExpo,
                              snappingDuration: Duration(milliseconds: 500),
                              grabbingContentOffset: GrabbingContentOffset.top,
                            ),
                          ],
                          grabbing: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 45,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          sheetBelow: SnappingSheetContent(
                            draggable: true,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45),
                                ),
                              ),
                              child: DefaultTabController(
                                length: 3,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10.0),
                                    const TabBar(
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      indicatorColor: Colors.deepPurple,
                                      labelStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                      unselectedLabelStyle:
                                          TextStyle(fontSize: 16.0),
                                      tabs: [
                                        Tab(text: '추천순'),
                                        Tab(text: '최신순'),
                                        Tab(text: '내 리뷰'),
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          reviewTab(context, hall, true, false),
                                          reviewTab(
                                              context, hall, false, false),
                                          reviewTab(context, hall, false, true)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8.0),
                                    child: Image.network(
                                      hall.hallImage ?? "",
                                      fit: BoxFit.cover,
                                      height: 360,
                                    ),
                                  ),
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
        });
  }
}
