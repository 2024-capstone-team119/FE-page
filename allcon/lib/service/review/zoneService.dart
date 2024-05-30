import 'dart:async';
import 'dart:convert';
import 'package:allcon/model/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:allcon/service/baseUrl.dart';

class ZoneService {
  // Zone 데이터 조회하기
  static Future<List<Zone>?> getZone(String hallId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}get_zone/$hallId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Zone data retrieved successfully.");
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Zone.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        print("Zone not found.");
        return null;
      } else {
        print("Failed to retrieve zone: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while retrieving zone: $e");
      return null;
    }
  }
}
