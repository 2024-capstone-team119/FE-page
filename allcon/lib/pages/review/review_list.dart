import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewList extends StatefulWidget {
  final int index;

  const ReviewList({
    super.key,
    required this.index,
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
                  _reviewController.reviews[widget.index].writer,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  children: _reviewController.starCounts(
                      _reviewController.reviews[widget.index].starCount),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(_reviewController.reviews[widget.index].content),
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
                        setState(() {
                          _reviewController.reviews[widget.index].goodCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good (${_reviewController.reviews[widget.index].goodCount})',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _reviewController.reviews[widget.index].badCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(
                        'Bad (${_reviewController.reviews[widget.index].badCount})',
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('yyyy-MM-dd')
                      .format(_reviewController.reviews[widget.index].dateTime),
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
