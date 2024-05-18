import 'package:allcon/service/baseUrl.dart';
import 'package:http/http.dart' as http;

class DeleteUserService {
  // 회원 탈퇴
  static Future<bool> deleteUser(String userId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}delete_user/$userId");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print("User has been deactivated successfully.");
        return true;
      } else {
        print("Failed to deactivate user: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred while deactivating user: $e");
      return false;
    }
  }
}
