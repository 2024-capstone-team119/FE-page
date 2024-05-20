import 'dart:convert';
import 'package:allcon/model/community_model.dart';
import 'package:allcon/service/baseUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostService {
  // post method
  static addPost(postData) async {
    var url = Uri.parse('${BaseUrl.baseUrl}add_post');

    try {
      // 이건 Node 서버에 데이터를 보내는 코드
      final res = await http.post(url, body: postData);

      // Node 서버에서 응답이 긍정적
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      }
      // Node 서버에서 응답이 부정적
      else {
        print('failed to get response');
      }
    }
    //  Node와의 연결에 문제가 생겼을 때
    catch (e) {
      debugPrint(e.toString());
    }
  }

  // 글 조회 API
  static Future<List<Post>> getPost(String category) async {
    var url = Uri.parse('${BaseUrl.baseUrl}get_post/$category');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == "조회 성공!") {
        List<dynamic> postData = jsonResponse['data'];
        return postData.map((data) => Post.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // 글 수정 API
  static updatePost(id, postToUpdate) async {
    var url = Uri.parse('${BaseUrl.baseUrl}update_post/$id');

    final res = await http.patch(url, body: postToUpdate);

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("failed to update,,,,");
    }
  }

  // 글 삭제 API
  static deletePost(id) async {
    var url = Uri.parse('${BaseUrl.baseUrl}delete_post/$id');

    final res = await http.post(url);

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("failed to update,,,,");
    }
  }

  // 글 검색 API
  static Future<List<Post>> searchPosts(
      String searchText, String category) async {
    var url = Uri.parse("${BaseUrl.baseUrl}search_posts");
    try {
      print(searchText);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'searchText': searchText, 'category': category}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((data) => Post.fromJson(data)).toList();
      } else if (response.statusCode == 404) {
        return []; // 검색 결과가 없을 경우 빈 리스트 반환
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error occurred while searching posts: $e');
      throw Exception('Error occurred while searching posts');
    }
  }
}
