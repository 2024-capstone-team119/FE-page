import 'dart:convert';
import 'package:allcon/service/baseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class loginService {
  static Future<bool> loginUser(String email, String password) async {
    var url = Uri.parse('${BaseUrl.baseUrl}login');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        String? token = jsonResponse['token'];
        String? nickname = jsonResponse['nickname'];
        String? userId = jsonResponse['userId'];

        if (token == null || nickname == null || userId == null) {
          print('응답에서 필요한 데이터가 없습니다.');
          return false;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userNickname', nickname);
        await prefs.setString('userId', userId);
        print("로그인한 유저의 정보");
        print("$token\n$nickname\n$userId");
        return true;
      } catch (e) {
        // JSON 파싱 실패
        print('JSON 파싱 오류: $e');
        return false;
      }
    } else {
      // JSON이 아닌 응답이 반환될 수 있음
      print('서버 에러: ${response.body}');
      return false;
    }
  }
}
