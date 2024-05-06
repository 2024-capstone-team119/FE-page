import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewList extends StatefulWidget {
  final Review review;

  const ReviewList({
    super.key,
    required this.review,
  });

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late final ReviewController _reviewController;

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.review.writer,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  children:
                      _reviewController.starCounts(widget.review.starCount),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(widget.review.content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Helpful ?',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        _reviewController
                            .incrementGoodCount(widget.review.reviewId);
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good (${widget.review.goodCount})',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.review.badCount++;
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
                  DateFormat('yyyy-MM-dd').format(widget.review.dateTime),
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
