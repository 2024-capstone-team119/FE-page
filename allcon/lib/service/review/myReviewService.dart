import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/baseUrl.dart';

class MyReviewService {
  // 내 리뷰 조회
  static Future<List<Review>> getMyReviews(String userId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}my_review/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  // 리뷰 수정
  static Future<void> updateReview(String reviewId, String userId,
      String reviewToUpdate, int ratingToUpdate) async {
    var url = Uri.parse('${BaseUrl.baseUrl}modify_review/$reviewId');
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'userId': userId,
      'reviewText': reviewToUpdate,
      'rating': ratingToUpdate,
    }); // 본문 데이터를 JSON 문자열로 인코딩

    final res = await http.put(url,
        headers: headers, body: body); // headers와 body를 put 요청에 추가

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("Failed to update comment: ${res.body}");
    }
  }

  // 리뷰 삭제
  static Future<bool> deleteReview(String reviewId, String zoneId) async {
    final url = '${BaseUrl.baseUrl}delete_review/$reviewId';
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'zoneId': zoneId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete review: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }
}
