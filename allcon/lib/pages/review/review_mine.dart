import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewMine extends StatefulWidget {
  final int index;

  const ReviewMine({
    super.key,
    required this.index,
  });

  @override
  State<ReviewMine> createState() => _ReviewMineState();
}

class _ReviewMineState extends State<ReviewMine> {
  late final ReviewController reviewController;

  @override
  void initState() {
    super.initState();
    reviewController = Get.put(ReviewController());
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext sheetContext) =>
                          CupertinoActionSheet(
                        title: const Text('옵션'),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('수정'),
                            onPressed: () {},
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('삭제'),
                            onPressed: () {
                              // You can handle content deletion
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
                    Icons.more_vert,
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
                const Text(
                  '1구역',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  children: reviewController.starCounts(
                      reviewController.reviews[widget.index].starCount),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(reviewController.reviews[widget.index].content),
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
                          reviewController.reviews[widget.index].goodCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good (${reviewController.reviews[widget.index].goodCount})',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          reviewController.reviews[widget.index].badCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(
                        'Bad (${reviewController.reviews[widget.index].badCount})',
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('yyyy-MM-dd')
                      .format(reviewController.reviews[widget.index].dateTime),
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
