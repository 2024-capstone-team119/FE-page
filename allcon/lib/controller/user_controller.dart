import 'package:allcon/service/userRepository.dart';
import 'package:allcon/utils/jwt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  final RxBool isLogin = false.obs;

  Future<String> login(String email, String password) async {
    String token = await _userRepository.login(email, password);

    if (token != "-1") {
      isLogin.value = true;
      jwtToken = token;
    }
    return token;
  }
}
