import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/ReviewUpdate.dart';
import 'package:allcon/pages/review/ReviewWrite.dart';
import 'package:allcon/service/review/myReviewService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ReviewController extends GetxController {
  RxList<Review> reviews = <Review>[].obs;
  RxList<Review> myReviews = <Review>[].obs;

  ReviewController._internal();

  factory ReviewController() {
    return ReviewController._internal();
  }

  // 일반 리뷰 목록
  void setReviewList(List<Review> initialReviews) {
    reviews.assignAll(initialReviews);
  }

  // 내 리뷰 목록
  Future<void> setMyReviewList(
      List<Review> initialReviews, String? userId) async {
    if (userId != '') {
      try {
        List<Review> fetchedReviews =
            await MyReviewService.getMyReviews(userId!);

        myReviews.assignAll(fetchedReviews);
      } catch (error) {
        print('Error fetching reviews: $error');
      }
    } else {
      print('Loading');
    }
  }

  // 별점 표시
  List<Widget> starCounts(int starCount) {
    List<Widget> starIcons = [];

    for (int i = 0; i < 5; i++) {
      if (i < starCount) {
        starIcons.add(
            const Icon(CupertinoIcons.star_fill, color: Colors.amberAccent));
      } else {
        starIcons.add(const Icon(CupertinoIcons.star, color: Colors.black12));
      }
    }
    return starIcons;
  }

  // 리뷰 작성 모달
  Future<bool?> showWriteModalSheet(BuildContext context, String zoneId,
      String zoneName, String userId, String userNickname) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ReviewWrite(
          zoneId: zoneId,
          zoneName: zoneName,
          userId: userId,
          userNickname: userNickname,
        );
      },
    );
  }

  // 리뷰 수정 모달
  void showUpdateModalSheet(
    BuildContext context,
    String userId,
    Review review,
    List<Zone> zones,
    VoidCallback reloadCallback,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ReviewUpdate(
          userId: userId,
          review: review,
          zones: zones,
          reloadCallback: reloadCallback,
        );
      },
    );
  }
}
