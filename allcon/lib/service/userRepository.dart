import 'package:allcon/model/login_model.dart';
import 'package:allcon/service/userProvider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

// 통신 호출해서 응답되는 데이터를 가공
class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<String> login(String email, String password) async {
    LoginReqDto loginReqDto = LoginReqDto(email, password);
    Response response = await _userProvider.login(loginReqDto.toJson());
    dynamic headers = response.headers;

    if (headers["authorization"] == null) {
      return "-1";
    } else {
      String token = headers["authorization"];
      return token;
    }
  }
}
