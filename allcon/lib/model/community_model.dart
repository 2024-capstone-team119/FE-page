// 커뮤니티 글 모델

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Post {
  final String postId;
  final String category;
  final String userId;
  final String nickname;
  final String title;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int commentCount;
  final int likesCount;

  Post({
    required this.postId,
    required this.category,
    required this.userId,
    required this.nickname,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
    required this.likesCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    tz.initializeTimeZones(); // 시간대 데이터 초기화
    var seoul = tz.getLocation('Asia/Seoul'); // 'Asia/Seoul' 위치 객체 가져오기
    return Post(
      postId: json['_id'], // MongoDB의 _id 필드를 postId로 사용
      category: json['category'],
      userId: json['userId'],
      nickname: json['nickname'],
      title: json['title'],
      text: json['text'],

      // UTC에서 한국 시간대로 변환
      createdAt: tz.TZDateTime.from(DateTime.parse(json['createdAt']), seoul),
      updatedAt: tz.TZDateTime.from(DateTime.parse(json['updatedAt']), seoul),

      commentCount: json['commentCount'] ?? 0, // likeCounts가 null인 경우 0을 사용
      likesCount: json['likesCount'] ?? 0, // likeCounts가 null인 경우 0을 사용
    );
  }
}

class Comment {
  String postId;
  int commentId;
  String commentWriter;
  String commentContent;

  Comment({
    required this.postId,
    required this.commentId,
    this.commentWriter = '댓익명',
    required this.commentContent,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      commentId: json['commentId'],
      commentWriter: json['commentWriter'],
      commentContent: json['commentContent'],
    );
  }
}
