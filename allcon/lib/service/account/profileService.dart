import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:allcon/service/baseUrl.dart';

class ProfileService {
  static Future<bool> updateNickname(String userId, String newNickname) async {
    var url = Uri.parse("${BaseUrl.baseUrl}update_profile_nickname");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': userId,
          'nickname': newNickname,
        }),
      );

      if (response.statusCode == 200) {
        print("Nickname updated successfully.");
        return true;
      } else {
        print("Failed to update nickname: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred while updating nickname: $e");
      return false;
    }
  }

  // 2. 수정된 프로필 이미지 전송 API
  static Future<bool> uploadProfileImage(String userId, File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      print("$userId / $image");

      var url = Uri.parse("${BaseUrl.baseUrl}update_profile_image");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': userId,
          'userImage': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      } else {
        print("Failed to upload profile image: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred while uploading profile image: $e");
      return false;
    }
  }

  // 3. 프로필 이미지를 받아오는 API
  static Future<String?> getProfileImage(String userId) async {
    var url = Uri.parse("${BaseUrl.baseUrl}get_profile_image/$userId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['profileImage'];
    } else {
      print("Failed to load profile image: ${response.statusCode}");
      return null;
    }
  }
}
