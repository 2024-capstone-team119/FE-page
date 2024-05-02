// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'baseUrl.dart';

class RegistService {
  // 이메일 중복 확인
  static Future<http.Response> checkEmailExists(String email) async {
    var url = Uri.parse("${BaseUrl.baseUrl}check_email_exists?email=$email");

    try {
      final res = await http.get(url);
      return res; // 이제 전체 응답을 반환
    } catch (e) {
      // 오류 처리를 여기서 수행, 오류 응답 생성
      return http.Response('{"exists": true, "error": "Network error"}', 500);
    }
  }

// 닉네임 중복 확인
  static Future<http.Response> checkNicknameExists(String nickname) async {
    var url =
        Uri.parse('${BaseUrl.baseUrl}check_nickname_exists?nickname=$nickname');

    try {
      final res = await http.get(url);
      return res; // 이제 전체 응답을 반환
    } catch (e) {
      // 오류 처리를 여기서 수행, 오류 응답 생성
      return http.Response('{"exists": true, "error": "Network error"}', 500);
    }
  }

  // user 가입 method
  static addUser(userData) async {
    var url = Uri.parse('${BaseUrl.baseUrl}registration');

    try {
      // 이건 Node 서버에 데이터를 보내는 코드
      final res = await http.post(url, body: userData);

      // Node 서버에서 응답이 긍정적
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      }
      // Node 서버에서 응답이 부정적
      else {
        print('failed to get response');
      }
    }
    //  Node와의 연결에 문제가 생겼을 때
    catch (e) {
      debugPrint(e.toString());
    }
  }
}
