import 'package:allcon/service/account/tokenService.dart';
import 'package:allcon/utils/jwt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final tokenService _tokenService = tokenService();

  final RxBool isLogin = false.obs;

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
