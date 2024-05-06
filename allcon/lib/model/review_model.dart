import 'package:flutter/material.dart';
// 공연장 시야 리뷰

// 공연장
class Hall {
  int hallIdx;
  String hallName;
  Widget? seatingChart; // 좌석 배치도
  List<Zone> zone;

  Hall({
    required this.hallIdx,
    required this.hallName,
    required this.seatingChart,
    required this.zone,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      hallIdx: json['hallIdx'],
      hallName: json['hallName'],
      seatingChart: json['seatingChart'],
      zone: (json['zone'] as List<dynamic>)
          .map((zoneJson) => Zone.fromJson(zoneJson))
          .toList(),
    );
  }
}

// 공연장 구역
class Zone {
  int zoneIdx;
  String zoneName;
  List<Review> review;

  Zone({
    required this.zoneIdx,
    required this.zoneName,
    required this.review,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      zoneIdx: json['zoneIdx'],
      zoneName: json['zoneName'],
      review: (json['review'] as List<dynamic>)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
    );
  }
}

// 리뷰
class Review {
  int reviewId;
  String writer;
  String content;
  String image;
  int starCount;
  int goodCount;
  int badCount;
  DateTime dateTime;

  Review({
    required this.reviewId,
    required this.writer,
    required this.content,
    required this.image,
    required this.starCount,
    required this.goodCount,
    required this.badCount,
    required this.dateTime,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['reviewId'],
      writer: json['writer'],
      content: json['content'],
      image: json['image'],
      starCount: json['startCount'],
      goodCount: json['goodCount'],
      badCount: json['badCount'],
      dateTime: json['dateTime'],
    );
  }
}
