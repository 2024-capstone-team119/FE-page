import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/sub/ReviewUpdate.dart';
import 'package:allcon/pages/review/sub/ReviewWrite.dart';
import 'package:allcon/service/review/myReviewService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  RxList<Review> reviews = <Review>[].obs;
  RxList<Review> recommendReviews = <Review>[].obs;
  RxList<Review> myReviews = <Review>[].obs;

  RxInt goodCounts = 0.obs;

  ReviewController._internal();

  factory ReviewController() {
    return ReviewController._internal();
  }

  // 일반 리뷰 목록
  void setReviewList(List<Review> initialReviews) {
    reviews.assignAll(initialReviews);
  }

  // 추천순 리뷰 목록
  void setRecommendReviewList(List<Review> initialReviews) {
    recommendReviews.assignAll(initialReviews);
  }

  // 내 리뷰 목록
  Future<void> setMyReviewList(
      List<Review> initialReviews, String? userId, String? hallId) async {
    if (userId != '') {
      try {
        List<Review> fetchedReviews =
            await MyReviewService.getMyReviews(userId!, hallId!);

        myReviews.assignAll(fetchedReviews);
      } catch (error) {
        print('Error fetching reviews: $error');
      }
    } else {
      print('Loading');
    }
  }

  void setGoodCounts() {
    goodCounts = 0.obs;
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
    String userNickname,
    Review review,
    List<Zone> zones,
    List<String> imageUrls,
    VoidCallback reloadCallback,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ReviewUpdate(
          userId: userId,
          userNickname: userNickname,
          review: review,
          zones: zones,
          imageUrls: imageUrls,
          reloadCallback: reloadCallback,
        );
      },
    );
  }
}
