import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/ReviewUpdate.dart';
import 'package:allcon/pages/review/ReviewWrite.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ReviewController extends GetxController {
  RxList<Review> reviews = <Review>[].obs;
  RxBool isModalOpen = false.obs;

  ReviewController._internal();

  factory ReviewController() {
    return ReviewController._internal();
  }

  // 리뷰 목록
  void setReviewList(List<Review> initialReviews) {
    reviews.assignAll(initialReviews);
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
  void showWriteModalSheet(
      BuildContext context, List<Review> reviewList, String zone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ReviewWrite(
          reviewList: reviewList,
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

  // 리뷰 수정 모달
  void showUpdateModalSheet(
    BuildContext context,
    List<Review> reviewList,
    List<Zone> zoneList,
    List<String> zoneTotal,
    String zone,
    Review review,
    String text,
    int star,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ReviewUpdate(
          reviewList: reviewList,
          zoneList: zoneList,
          zoneTotal: zoneTotal,
          zone: zone,
          selectedReview: review,
          reviewId: reviews.length,
          text: text,
          star: star,
        );
      },
    );
  }

  // 리뷰 수정 함수
  void updateReview(Review updateReview, Review originReview, String originZone,
      List<Zone> zoneList, int selectedIdx) {
    // 옮길 구역의 리뷰 리스트
    List<Review> targetZoneReviews = zoneList[selectedIdx].review;

    // 수정된 리뷰의 목표 위치
    int targetIndex = 0;
    for (int i = 0; i < targetZoneReviews.length; i++) {
      if (targetZoneReviews[i].reviewId > updateReview.reviewId) {
        targetIndex = i;
        break;
      }
    }

    // 수정된 리뷰 제거
    int oldZoneIndex =
        zoneList.indexWhere((zone) => zone.zoneName == originZone);
    zoneList[oldZoneIndex]
        .review
        .removeWhere((review) => review.reviewId == updateReview.reviewId);

    // 목표 위치에 수정된 리뷰 추가
    zoneList[selectedIdx].review.insert(
          targetIndex,
          updateReview,
        );

    // 리뷰 업데이트
    final int index = reviews
        .indexWhere((review) => review.reviewId == updateReview.reviewId);

    if (index != -1) {
      reviews[index] = updateReview;
      update();
    }
  }
}
