import 'package:allcon/service/account/tokenService.dart';
import 'package:allcon/utils/jwt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  // 사용자의 로그인 상태 관리
  final RxBool isLogin = false.obs;

  final _secureStorage = const FlutterSecureStorage();

  // 로그인 요청을 하고 -> 성공시 jwt 토큰을 받아옴
  final tokenService _tokenService = tokenService();
  Future<String> login(String email, String password) async {
    String token = await _tokenService.login(email, password);

    if (token != "-1") {
      isLogin.value = true;
      jwtToken = token;

      // 토큰을 secure storage에 저장
      await _secureStorage.write(key: 'jwt_token', value: token);
    }
    return token;
  }

  void logout() {
    isLogin.value = false;
    jwtToken = null;

    // 토큰을 secure storage에서 삭제
    _secureStorage.delete(key: 'jwt_token');
  }
}
