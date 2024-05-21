import 'dart:convert';
import 'package:allcon/model/community_model.dart';
import 'package:http/http.dart' as http;
import 'package:allcon/service/baseUrl.dart';

class MyContentService {
  static Future<List<Post>> getMyPost(String userId) async {
    print(userId);

    List<Post> posts = [];
    var url = Uri.parse("${BaseUrl.baseUrl}get_my_posts/$userId");
    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        for (var post in data) {
          posts.add(Post.fromJson(post));
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Failed to fetch data: $e");
      return [];
    }

    return posts;
  }
}
