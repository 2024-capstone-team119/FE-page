import 'dart:convert';
import 'package:allcon/model/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:allcon/service/baseUrl.dart';

class ReviewService {
  // 리뷰 작성 API
  static Future<bool> addReview(
      String userId,
      String userNickname,
      String reviewText,
      int rating,
      String zoneId,
      List<String> imageFiles) async {
    try {
      print("imageFiles type: ${imageFiles.runtimeType}"); // 타입 출력

      var url = Uri.parse("${BaseUrl.baseUrl}upload_review");
      var request = http.MultipartRequest('POST', url);

      // Add text data
      request.fields.addAll({
        'userId': userId,
        'userNickname': userNickname,
        'reviewText': reviewText,
        'rating': rating.toString(),
        'zoneId': zoneId,
      });

      // Add image files
      for (var file in imageFiles) {
        request.files.add(await http.MultipartFile.fromPath('review', file));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print("Failed to submit review: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred while submitting review: $e");
      return false;
    }
  }

  // 리뷰 조회 API
  static Future<List<Review>> getReviews(String zoneId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}get_review/$zoneId');

    print("api로 전달하는 zoneId : $zoneId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Review> reviews =
          jsonResponse.map((json) => Review.fromJson(json)).toList();

      // 리스트 항목들을 하나씩 print
      for (var review in reviews) {
        print('Review ID: ${review.reviewId}');
        print('Zone ID: ${review.zoneId}');
        print('User ID: ${review.userId}');
        print('Nickname: ${review.nickname}');
        print('Text: ${review.text}');
        print('Image: ${review.image}');
        print('Created At: ${review.createdAt}');
        print('Updated At: ${review.updatedAt}');
        print('Good Count: ${review.goodCount}');
        print('Bad Count: ${review.badCount}');
        print('Rating: ${review.rating}');
        print('---');
      }
      print('리뷰: $reviews');
      return reviews;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  // 리뷰 좋아요 싫어요 조회
  static Future<List<bool>> fetchReactionReview(
      String reviewId, String userId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}review_status/$reviewId/$userId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      bool isGood = data['isGood'] ?? false;
      bool isBad = data['isBad'] ?? false;
      return [isGood, isBad];
    } else {
      print('Failed to fetch review reaction: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [false, false];
    }
  }

  // 리뷰 좋아요 토글
  static Future<int> toggleGoodReview(String reviewId, String userId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}review_good/$reviewId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      bool isGood = jsonResponse['isGood'];
      return isGood ? 1 : 0;
    } else if (response.statusCode == 400) {
      if (response.body.contains("이미 Bad로 표시된 리뷰입니다")) {
        return 2;
      }
    }

    print('Failed to toggle review good: ${response.statusCode}');
    print('Response body: ${response.body}');
    return -1;
  }

  // 리뷰 싫어요 토글
  static Future<int> toggleBadReview(String reviewId, String userId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}review_bad/$reviewId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      bool isBad = jsonResponse['isBad'];
      return isBad ? 1 : 0;
    } else if (response.statusCode == 400) {
      if (response.body.contains("이미 Good으로 표시된 리뷰입니다")) {
        return 2;
      }
    }

    print('Failed to toggle review good: ${response.statusCode}');
    print('Response body: ${response.body}');
    return -1;
  }
}
