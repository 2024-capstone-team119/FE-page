import 'dart:convert';
import 'package:allcon/model/concertLikes_model.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/baseUrl.dart';
import 'package:http/http.dart' as http;

class ConcertLikesService {
  // 1. 공연 상세 페이지에서 좋아요 상태 확인 API (얘로 하트버튼 초기화!)
  static Future<bool> isFavorited(String userId, String performanceId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}isFavorited/$userId/$performanceId");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['isFavorited']; // 서버에서 반환된 좋아요 상태 (true or false)
      } else {
        print('API 호출 실패: ${response.body}');
        return false; // API 호출 실패 시 기본적으로 false 반환
      }
    } catch (e) {
      print('API 호출 중 에러 발생: $e');
      return false; // 네트워크 에러 시 false 반환
    }
  }

  // 2. 관심 공연 toggle API
  static Future<Map<String, dynamic>> toggleFavorite(
      String userId, String performanceId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}favorite/$performanceId");
    var response = await http.post(url, body: {'userId': userId});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return {
        'message': data['message'],
        'favorited': data['favorited'],
      };
    } else {
      // 요청 실패 시, 오류 메시지와 함께 빈 결과 반환
      print('API 호출 실패: ${response.body}');
      return {
        'message': 'API 호출에 실패했습니다',
        'favorited': null,
      };
    }
  }

  // 3.관심공연 리스트 조회 api
  static Future<List<Performance>> getFavoritePerformances(
      String userId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}favoriteList/$userId");
    print(userId);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['favorites'];
      return data
          .map((json) => Performance.fromJson(json['performance']))
          .toList();
    } else {
      throw Exception('Failed to load favorite performances');
    }
  }
}
