import 'package:allcon/model/request/LoginReqModel.dart';
import 'package:allcon/service/account/loginService.dart';
import 'package:get/get_connect/http/src/response/response.dart';

// 통신 호출해서 응답되는 데이터를 가공
// 서버 API와 통신 및 응답에서 JWT 토큰 추출
class tokenService {
  final LoginService _loginService = LoginService();

  Future<String> login(String email, String password) async {
    LoginReqModel loginReqModel = LoginReqModel(email, password);
    Response response = await _loginService.login(loginReqModel.toJson());
    dynamic headers = response.headers;

    if (headers["authorization"] == null) {
      return "-1";
    } else {
      String token = headers["authorization"];
      return token;
    }
  }
}
