import 'dart:convert';
import 'dart:typed_data';
import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/ReviewMain.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/service/review/myReviewService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyReview extends StatefulWidget {
  final String placeTitle;
  final String placeId;
  final Hall hall;
  final String userId;
  final Review review;
  final List<Zone> zones;

  const MyReview({
    super.key,
    required this.placeTitle,
    required this.placeId,
    required this.hall,
    required this.userId,
    required this.review,
    required this.zones,
  });

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  late final ReviewController _reviewController;
  String? zoneName;

  void _reloadMyReview() {
    Get.off(ReviewMain(
      title: widget.placeTitle,
      placeId: widget.placeId,
      initialTab: 2,
    ));

    print('이동');
  }

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (widget.review.image != null && widget.review.image!.isNotEmpty) {
      imageBytes = base64Decode(widget.review.image!);
    }

    zoneName = widget.zones
        .firstWhere((zone) => zone.zoneId == widget.review.zoneId)
        .zoneName;

    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 수정 버튼
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _reviewController.showUpdateModalSheet(
                        context,
                        widget.userId,
                        widget.review,
                        widget.zones,
                        _reloadMyReview,
                      );
                    });
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 10),
                // 삭제 버튼
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
                                  widget.review.reviewId, widget.review.zoneId);
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
                    Icons.delete,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                  children: _reviewController.starCounts(widget.review.rating),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(widget.review.text),
            ),
            Container(
              child: imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        imageBytes,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Helpful ?',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.review.goodCount;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good (${widget.review.goodCount})',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.review.badCount;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(
                        'Bad (${widget.review.badCount})',
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
