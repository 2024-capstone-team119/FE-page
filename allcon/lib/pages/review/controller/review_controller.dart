import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/review_write.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  RxList<Review> reviews = <Review>[].obs;

  ReviewController._internal();

  factory ReviewController() {
    return ReviewController._internal();
  }

  // 리뷰 목록
  void setReviewList(List<Review> initialReviews) {
    reviews.assignAll(initialReviews);
    reviews.refresh();
  }

  // 별점 표시
  List<Widget> starCounts(int starCount) {
    List<Widget> starIcons = [];

    for (int i = 0; i < 5; i++) {
      if (i < starCount) {
        starIcons.add(const Icon(CupertinoIcons.star_fill, color: lightMint));
      } else {
        starIcons.add(const Icon(CupertinoIcons.star, color: Colors.black12));
      }
    }
    return starIcons;
  }

  // 리뷰 작성 모달
  void showModalSheet(BuildContext context, String zone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ReviewWrite(
          reviewList: reviews,
          zone: zone,
          reviewId: reviews.length,
        );
      },
    );
  }

  // 리뷰 작성 함수
  void submitReview(Review newReview, List<Review> reviewList) {
    reviewList.add(newReview);
    reviews.refresh();
  }
}
