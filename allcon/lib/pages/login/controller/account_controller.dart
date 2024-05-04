import 'package:allcon/service/account/tokenService.dart';
import 'package:allcon/utils/jwt.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  // 사용자의 로그인 상태 관리
  final RxBool isLogin = false.obs;

  // 로그인 요청을 하고 -> 성공시 jwt 토큰을 받아옴
  final tokenService _tokenService = tokenService();
  Future<String> login(String email, String password) async {
    String token = await _tokenService.login(email, password);

    if (token != "-1") {
      isLogin.value = true;
      jwtToken = token;
    }
    return token;
  }

  void logout() {
    isLogin.value = false;
    jwtToken = null;
  }
}
