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
  static Future<String?> uploadProfileImage(String userId, File image) async {
    try {
      var url = Uri.parse("${BaseUrl.baseUrl}modify_profile_image");

      var request = http.MultipartRequest('POST', url);
      request.fields['userId'] = userId;
      request.files
          .add(await http.MultipartFile.fromPath('profile', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("success to upload profile image");
        return responseData;
      } else {
        print("Failed to upload profile image: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while uploading profile image: $e");
      return null;
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
