import 'package:allcon/service/account/loginService.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final RxBool isLogin = false.obs;

  Future<bool> login(String email, String password) async {
    bool isToken = await loginService.loginUser(email, password);

    isLogin.value = true;
    return isToken;
  }

  void logout() {
    isLogin.value = false;
  }
}
