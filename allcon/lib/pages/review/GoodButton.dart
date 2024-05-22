import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodButton extends StatefulWidget {
  final Review review;
  final String userId;

  const GoodButton({
    super.key,
    required this.review,
    required this.userId,
  });

  @override
  State<GoodButton> createState() => _GoodButtonState();
}

class _GoodButtonState extends State<GoodButton> {
  late bool isGood = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ReviewService.toggleGoodReview(
        widget.review.reviewId,
        widget.userId,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Icon(CupertinoIcons.hand_thumbsup));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          isGood = snapshot.data!;
          print(isGood);

          return TextButton(
            onPressed: () async {
              print('전: $isGood');
              print('토글');
              print(widget.review.reviewId);
              setState(() {
                isGood = !isGood;
              });
              await ReviewService.toggleGoodReview(
                widget.review.reviewId,
                widget.userId,
              );
              print('후: $isGood');
            },
            style: TextButton.styleFrom(
                foregroundColor: isGood ? Colors.blue : Colors.grey),
            child: Text(
              'Good (${widget.review.goodCount})',
            ),
          );
        } else {
          return const Center(child: Text('No goodCounts found'));
        }
      },
    );
  }
}
