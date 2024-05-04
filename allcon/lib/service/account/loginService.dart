import 'package:get/get.dart';

class LoginService extends GetConnect {
  Future<Response> login(Map data) => post("${baseUrl}/login", data);
}
