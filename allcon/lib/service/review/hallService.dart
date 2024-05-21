import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/baseUrl.dart';

class HallService {
  // Hall 데이터 가져오기
  static Future<Hall?> getHall(String placeId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}get_hall/$placeId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Hall data retrieved successfully.");
        return Hall.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        print("Hall not found.");
        return null;
      } else {
        print("Failed to retrieve hall: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while retrieving hall: $e");
      return null;
    }
  }
}
