import 'dart:convert';
import 'package:http/http.dart' as http;
import 'baseUrl.dart';

class RegistService {
// Check if the email already exists
  Future<bool> checkEmailExists(String email) async {
    try {
      final response = await http
          .get(Uri.parse('${BaseUrl.baseUrl}check_email_exists/$email'));
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return jsonDecode(response.body)['exists'];
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to check email');
      }
    } catch (e) {
      print('Error occurred while checking email: $e');
      return false; // Consider the proper way to handle error states
    }
  }

// Check if the nickname already exists
  Future<bool> checkNicknameExists(String nickname) async {
    try {
      final response = await http
          .get(Uri.parse('${BaseUrl.baseUrl}check_nickname_exists/$nickname'));
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return jsonDecode(response.body)['exists'];
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to check nickname');
      }
    } catch (e) {
      print('Error occurred while checking nickname: $e');
      return false; // Consider the proper way to handle error states
    }
  }

// Register a new user
  Future<dynamic> registerUser(
      String email, String password, String nickname) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseUrl.baseUrl}registration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'nickname': nickname}),
      );
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return jsonDecode(response.body);
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error occurred during registration: $e');
      return e.toString(); // Consider the proper way to handle error states
    }
  }
}
