import 'package:allcon/service/account/deleteUserService.dart';
import 'package:allcon/service/account/loginService.dart';
import 'package:allcon/service/account/tokenService.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  RxBool isLogin = false.obs;

  Future<bool> login(String email, String password) async {
    bool isToken = await loginService.loginUser(email, password);
    isLogin.value = isToken;
    return isToken;
  }

  void logout() async {
    isLogin.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('loginUserEmail');
    await prefs.remove('userNickname');
  }

  Future<bool> deleteUser(String userId) async {
    bool isDelete = await DeleteUserService.deleteUser(userId);
    if (isDelete) {
      isLogin.value = false;
      TokenService.removeToken();
    }
    return isDelete;
  }
}
