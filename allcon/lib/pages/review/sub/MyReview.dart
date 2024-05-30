import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/ReviewMain.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/service/review/myReviewService.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/widget/review/custom_show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyReview extends StatefulWidget {
  final String placeTitle;
  final String placeId;
  final Hall hall;
  final String userId;
  final String userNickname;
  final Review review;
  final List<Zone> zones;

  const MyReview({
    super.key,
    required this.placeTitle,
    required this.placeId,
    required this.hall,
    required this.userId,
    required this.userNickname,
    required this.review,
    required this.zones,
  });

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  late final ReviewController _reviewController;
  String? zoneName;
  late bool isGood = false;
  late bool isBad = false;
  late int goodCount;
  late int badCount;

  void _reloadMyReview() {
    Get.off(ReviewMain(
      title: widget.placeTitle,
      placeId: widget.placeId,
      initialTab: 2,
    ));
  }

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
    goodCount = widget.review.goodCount;
    badCount = widget.review.badCount;
    _fetchGoodNBad();
  }

  // 좋아요 싫어요 조회
  Future<void> _fetchGoodNBad() async {
    List<bool> result = await ReviewService.fetchReactionReview(
        widget.review.reviewId, widget.userId);
    setState(() {
      isGood = result[0];
      isBad = result[1];
    });
  }

  // 좋아요 토글
  Future<void> _toggleGood() async {
    int result = await ReviewService.toggleGoodReview(
        widget.review.reviewId, widget.userId);
    setState(() {
      if (result == 1) {
        isGood = true;
        goodCount++;
      } else if (result == 0) {
        isGood = false;
        goodCount--;
      } else if (result == 2) {
        customShowToast('이미 Bad로 표시된 리뷰입니다', context);
      }
    });
  }

  // 싫어요 토글
  Future<void> _toggleBad() async {
    int result = await ReviewService.toggleBadReview(
        widget.review.reviewId, widget.userId);
    setState(() {
      if (result == 1) {
        isBad = true;
        badCount++;
      } else if (result == 0) {
        isBad = false;
        badCount--;
      } else if (result == 2) {
        customShowToast('이미 Good으로 표시된 리뷰입니다', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    zoneName = widget.zones
        .firstWhere((zone) => zone.zoneId == widget.review.zoneId)
        .zoneName;

    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$zoneName구역',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children:
                          _reviewController.starCounts(widget.review.rating),
                    ),
                    SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext sheetContext) =>
                              CupertinoActionSheet(
                            title: const Text('옵션'),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: const Text('리뷰 삭제'),
                                onPressed: () {
                                  MyReviewService.deleteReview(
                                      widget.review.reviewId,
                                      widget.review.zoneId);
                                  Get.back();
                                  _reloadMyReview();
                                },
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context, '취소');
                              },
                              child: const Text('취소'),
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        CupertinoIcons.delete_solid,
                        size: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(widget.review.text),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var imageUrl in widget.review.image)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Helpful?',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                      onPressed: () async {
                        await _toggleGood();
                      },
                      style: TextButton.styleFrom(
                          foregroundColor:
                              isGood ? Colors.blueAccent : Colors.grey),
                      child: Text(
                        'Good($goodCount)',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _toggleBad();
                      },
                      style: TextButton.styleFrom(
                          foregroundColor:
                              isBad ? Colors.red[300] : Colors.grey),
                      child: Text(
                        'Bad($badCount)',
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(widget.review.createdAt),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(color: Colors.black12),
          ],
        ),
      ),
    );
  }
}
