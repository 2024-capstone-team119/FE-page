import 'dart:convert';
import 'package:allcon/model/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:allcon/service/baseUrl.dart';
import 'package:image_picker/image_picker.dart';

class ReviewService {
  // 리뷰 작성 API
  static Future<bool> addReview(String userId, String userNickname,
      String reviewText, int rating, String zoneId, XFile? imageFile) async {
    try {
      String? base64Image;
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        base64Image = base64Encode(bytes);
      }

      var url = Uri.parse("${BaseUrl.baseUrl}add_review");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': userId,
          'userNickname': userNickname,
          'reviewText': reviewText,
          'rating': rating,
          'zoneId': zoneId,
          'image': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
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

      return reviews;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  // 리뷰 좋아요
  static Future<bool> toggleGoodReview(String reviewId, String userId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}review_good/$reviewId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      bool isGood = jsonResponse[0];
      return isGood;
    } else {
      print('Failed to toggle review good: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  // 리뷰 싫어요
  static Future<bool> toggleBadReview(String reviewId, String userId) async {
    final url = Uri.parse('${BaseUrl.baseUrl}review_bad/$reviewId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      bool isBad = jsonResponse[0];
      return isBad;
    } else {
      print('Failed to toggle review bad: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }
}
