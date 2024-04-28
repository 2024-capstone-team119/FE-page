import 'dart:convert';
import 'package:allcon/model/concertLikes_model.dart';
import 'package:allcon/service/baseUrl.dart';
import 'package:http/http.dart' as http;

class ConcertLikesService {
  // 등록한 좋아요한 콘서트 정보 요청
  Future<ConcertLikes?> fetchConcertLikes(
      http.Client client, String userId) async {
    // http://inu-allcon/concertLikes?userId=-NIVCK7LmyT6E1bumyAQ
    var url = Uri.http(BaseUrl.baseUrl, '/concertLikes', {'userId': userId});

    final response = await client.get(url);
    if (response.statusCode == 200) {
      final concertLikesMap = jsonDecode(response.body);
      if (concertLikesMap.containsKey("rows")) {
        if (concertLikesMap["rows"].length <= 0) return null;
        var concertLikes = ConcertLikes.fromJson(concertLikesMap["rows"][0]);
        return concertLikes;
      } else {
        throw Exception('No concert Likes data');
      }
    } else {
      throw Exception('Unable to fetch concertLikes from the REST API');
    }
  }

  // 좋아요 콘서트 정보 업데이트
  Future<bool> updateConcertLikes(
      http.Client client, ConcertLikes concertLikes) async {
    Uri url;
    if (concertLikes.id != "") {
      print('콘서트 좋아요 정보 업데이트');
      // http://inu-allcon/SetConcertLikes/{ItemFavorites ID}
      url = Uri.http(BaseUrl.baseUrl, '/SetConcertLikes/${concertLikes.id}');
    } else {
      print('콘서트 좋아요 최초 등록');
      // http://inu-allcon/AddConcertLikes
      url = Uri.http(BaseUrl.baseUrl, '/AddConcertLikes');
    }
    final body = json.encode(concertLikes.toJson());
    final response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
