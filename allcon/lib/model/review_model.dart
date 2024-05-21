import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// 공연장
class Hall {
  final String? hallId;
  final String? placeId;
  final String? hallImage; // 우리가 넣는 image! URL 형태!

  Hall({
    required this.hallId,
    required this.placeId,
    required this.hallImage,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      hallId: json['_id'],
      placeId: json['placeId'],
      hallImage: json['image'],
    );
  }
}

// 공연장 구역
class Zone {
  final String? hallId;
  final String? zoneId;
  final String? zoneName;

  Zone({
    required this.hallId,
    required this.zoneId,
    required this.zoneName,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      hallId: json['hallId'],
      zoneId: json['_id'],
      zoneName: json['zoneName'],
    );
  }
}

// 리뷰
class Review {
  final String reviewId;
  final String zoneId;
  final String userId;
  final String nickname;
  final String text;
  final String? image; // null을 허용하도록 수정
  final DateTime createdAt;
  final DateTime updatedAt;
  final int goodCount;
  final int badCount;
  final int rating; // rating 필드 추가

  Review({
    required this.reviewId,
    required this.zoneId,
    required this.userId,
    required this.nickname,
    required this.text,
    this.image, // null을 허용하도록 수정
    required this.createdAt,
    required this.updatedAt,
    required this.goodCount,
    required this.badCount,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    tz.initializeTimeZones(); // 시간대 데이터 초기화
    var seoul = tz.getLocation('Asia/Seoul'); // 'Asia/Seoul' 위치 객체 가져오기
    return Review(
      reviewId: json['_id'], // MongoDB의 _id 필드를 reviewId로 사용
      zoneId: json['zoneId'],
      userId: json['userId'],
      nickname: json['userNickname'],
      text: json['reviewText'],
      image: json['image'], // null을 허용하도록 수정
      createdAt: tz.TZDateTime.from(DateTime.parse(json['createdAt']), seoul),
      updatedAt: tz.TZDateTime.from(DateTime.parse(json['updatedAt']), seoul),
      goodCount: json['goodCount'],
      badCount: json['badCount'],
      rating:
          json['rating'] is int ? json['rating'] : int.parse(json['rating']),
    );
  }
}
