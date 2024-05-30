import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/widget/review/custom_show_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewList extends StatefulWidget {
  final Review review;
  final String userId;

  const ReviewList({
    super.key,
    required this.review,
    required this.userId,
  });

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late bool isGood = false;
  late bool isBad = false;
  late int goodCount;
  late int badCount;

  @override
  void initState() {
    super.initState();
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
        customShowToast('이미 싫어요한 리뷰입니다', context);
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
        customShowToast('이미 좋아요한 리뷰입니다', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.review.nickname,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < widget.review.rating; i++)
                      const Icon(Icons.star, color: Colors.amber),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(widget.review.text),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.review.image.length,
                itemBuilder: (context, index) {
                  return widget.review.image.isNotEmpty
                      ? Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.network(
                            widget.review.image[index],
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox.shrink();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Helpful?',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () async {
                        await _toggleGood();
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: isGood ? Colors.blue : Colors.grey),
                      child: Text(
                        'GOOD ($goodCount)',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _toggleBad();
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: isBad ? Colors.red : Colors.grey),
                      child: Text(
                        'BAD ($badCount)',
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(widget.review.createdAt),
                ),
              ],
            ),
            const Divider(color: Colors.black12),
          ],
        ),
      ),
    );
  }
}
