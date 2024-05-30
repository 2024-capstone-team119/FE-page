import 'dart:convert';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:allcon/service/baseUrl.dart';

class LikesService {
  // 사용자 ID에 따른 좋아요 누른 게시글 목록 조회
  static Future<List<Map<String, dynamic>>> getLikedPosts(String userId) async {
    var url = Uri.parse('${BaseUrl.baseUrl}likedPostList/$userId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      // 'likedPosts' 키에 해당하는 리스트를 Post 객체와 liked 정보를 포함하는 맵 리스트로 변환
      List<Map<String, dynamic>> posts = (jsonData['likedPosts'] as List)
          .map((item) => {
                'post': Post.fromJson(item['post']), // Post 객체
                'liked': item['liked'] // liked 상태
              })
          .toList();

      return posts;
    } else {
      // 에러 발생시 빈 리스트 반환
      throw Exception('Failed to load liked posts');
    }
  }

  static Future<Map<String, dynamic>?> likePost(
      String postId, String userId) async {
    var url = Uri.parse('${BaseUrl.baseUrl}postsLike/$postId');
    print('$postId $userId');
    var headers = {
      'Content-Type': 'application/json', // JSON 형식 명시
    };
    var body = jsonEncode({'userId': userId});

    try {
      final res = await http.post(url, headers: headers, body: body);
      if (res.statusCode == 200) {
        return jsonDecode(res.body); // JSON 데이터를 Map<String, dynamic>으로 반환
      } else {
        print('Failed to like post. Status code: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while liking post: $e');
    }
    return null;
  }

  static Future<bool> isPostLiked(String userId, String postId) async {
    var url = Uri.parse('${BaseUrl.baseUrl}isliked/$userId/$postId');

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        return data['isliked'];
      } else {
        print(
            'Failed to check if post is liked. Status code: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while checking if post is liked: $e');
    }
    return false;
  }
}
