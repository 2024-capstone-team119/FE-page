import 'package:get/get.dart';

class UserProvider extends GetConnect {
  Future<Response> login(Map data) => post("${baseUrl}/login", data);
}
