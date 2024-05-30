import 'dart:convert';
import 'package:allcon/model/community_model.dart';
import 'package:allcon/service/baseUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CommentService {
  // 댓글작성 API
  static Future<bool> addComment(
      String postId, Map<String, dynamic> commentData) async {
    var url = Uri.parse('${BaseUrl.baseUrl}posts/$postId/comments');
    var headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(commentData),
      );

      if (response.statusCode == 200) {
        // 상태 코드 검사
        var data = jsonDecode(response.body);
        print('Comment added: $data');
        return true; // 성공적으로 댓글을 추가함
      } else {
        print('Failed to add comment: ${response.statusCode}');
        return false; // 댓글 추가 실패
      }
    } catch (e) {
      debugPrint('Error adding comment: $e');
      return false; // 네트워크 오류 또는 기타 예외 발생
    }
  }

  // 댓글 조회 API
  static Future<List<Comment>> getComment(String postId) async {
    var url = Uri.parse('${BaseUrl.baseUrl}get/$postId/comments');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Comment> comments =
          body.map((dynamic item) => Comment.fromJson(item)).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // 댓글 수정 API
  static Future<void> updateComment(
      String postId, String commentId, String commentToUpdate) async {
    var url = Uri.parse('${BaseUrl.baseUrl}posts/$postId/comments/$commentId');
    var headers = {
      'Content-Type': 'application/json', // 헤더에 컨텐트 타입을 JSON으로 설정
    };
    var body = jsonEncode({'text': commentToUpdate}); // 본문 데이터를 JSON 문자열로 인코딩

    final res = await http.put(url,
        headers: headers, body: body); // headers와 body를 put 요청에 추가

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("Failed to update comment: ${res.body}");
    }
  }

  // 댓글 삭제 API
  static Future<void> deleteComment(String postId, String commentId) async {
    print("삭제할 postId : $postId");
    print("삭제할 commentId : $commentId");
    var url = Uri.parse('${BaseUrl.baseUrl}posts/$postId/comments/$commentId');
    final res = await http.delete(url);

    if (res.statusCode == 200) {
      print("Comment deleted successfully: ${jsonDecode(res.body)}");
    } else {
      print("Failed to delete comment, status code: ${res.statusCode}");
    }
  }
}
