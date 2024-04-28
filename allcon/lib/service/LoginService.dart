import 'package:http/http.dart' as http;
import 'package:allcon/pages/home/Home.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';

// 네이버 로그인 로직
Future<void> signInWithNaver() async {
  try {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    final NaverLoginResult result = await FlutterNaverLogin.logIn();
    NaverAccessToken naverAccessToken =
        await FlutterNaverLogin.currentAccessToken;

    var accessToken = naverAccessToken.accessToken;
    var tokenType = naverAccessToken.tokenType;

    // 서버로 토큰 전송
    await sendTokenToServer(accessToken, tokenType);
    print("result $result");
  } catch (error) {
    print('NaverLogin Error : $error');
  }
}

// 서버로 토큰 전송
Future<void> sendTokenToServer(String accessToken, String tokenType) async {
  try {
    var data = {'accessToken': accessToken, 'tokenType': tokenType};
    // 임시 url-> 수정하기
    var url = 'https://inu-allcon.com/login';

    // POST 요청 보내기
    var response = await http.post(
      Uri.parse(url),
      body: data,
    );

    // 응답 확인
    if (response.statusCode == 200) {
      print('Token sent successfully!');
      Get.to(const MyHome());
    } else {
      print('Failed to send token. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending token: $e');
  }
}
