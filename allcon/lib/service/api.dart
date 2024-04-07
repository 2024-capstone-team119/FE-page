import 'dart:convert';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/model/place_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://10.0.2.2:8080/api/";

  // 1. 공연목록 조회 (db상에 존재하는)
  static Future<List<Performance>> getPerformance_all_past() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/all/past");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformance_all_future() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/all/future");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformance_all_all() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/all/all");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformance_ko_past() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/ko/past");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformance_ko_future() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/ko/future");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformance_visit_past() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/visit/past");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformance_visit_future() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance/visit/future");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  // 2. 새로 추가된 공연목록 조회 (14일 이내 추가된)
  static Future<List<Performance>> getPerformanceNew_all() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_new/all");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformanceNew_ko() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_new/ko");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  static Future<List<Performance>> getPerformanceNew_visit() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_new/visit");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  // 3. 곧 열리는 공연목록 조회 (14일 이내)
  static Future<List<Performance>> getPerformanceApproaching_all() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_approaching/all");
    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        return [];
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return []; // 예외 발생 시 빈 리스트 반환
    }
    return performances;
  }

  static Future<List<Performance>> getPerformanceApproaching_ko() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_approaching/ko");
    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        return [];
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return []; // 예외 발생 시 빈 리스트 반환
    }
    return performances;
  }

  static Future<List<Performance>> getPerformanceApproaching_visit() async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_approaching/visit");
    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        return [];
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return []; // 예외 발생 시 빈 리스트 반환
    }
    return performances;
  }

  // 4. 공연 id로 공연목록 조회
  static Future<Performance?> getPerformanceById(String id) async {
    var url = Uri.parse("${baseUrl}get_performance/$id");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        // 서버에서 받은 데이터를 디코딩하여 Performance 객체로 변환
        var data = Performance.fromJson(jsonDecode(res.body));
        return data;
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
        return null; // 또는 throw Exception("에러 메시지");
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
      return null; // 또는 throw Exception("에러 메시지");
    }
  }

  // 4. 현재 공연장에서 예정인 공연목록 조회
  static Future<List<Performance>> getPerformanceInThisPlace(String id) async {
    try {
      List<Performance> performances = [];
      var url = Uri.parse("${baseUrl}get_performance_in_this_place/$id");
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        // Check if data is not empty
        if (data != null) {
          for (var performance in data) {
            performances.add(Performance.fromJson(performance));
          }
          return performances; // Return the list of performances
        } else {
          return []; // 데이터가 비어있으면 빈 리스트 반환
        }
      } else {
        return [];
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return []; // 예외 발생 시 빈 리스트 반환
    }
  }

  // 5. 검색한 텍스트로 공연목록 조회 (검색한 텍스트로 공연이름, 출연자이름)
  static Future<List<Performance>> getPerformanceByName(String name) async {
    List<Performance> performances = [];

    var url = Uri.parse("${baseUrl}get_performance_by_name/$name");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        print("서버 응답 코드가 200이 아닙니다. 응답 코드: ${res.statusCode}");
        // 특정 응답 코드에 따른 추가 처리 가능
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      // 예외 발생 시 처리
    }
    return performances;
  }

  // 6. 공연 get method 날짜로 조회 - 이건 쓸 일이 없을 거 같아
  static Future<List<Performance>> getPerformanceByDate(
      String st, String ed) async {
    List<Performance> performances = [];
    var url = Uri.parse("${baseUrl}get_performance/$st/$ed");
    final res = await http.get(url);
    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var performance in data) {
          performances.add(Performance.fromJson(performance));
        }
      } else {
        return [];
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return []; // 예외 발생 시 빈 리스트 반환
    }
    return performances;
  }

  // --

  // 1. 선택한 지역권의 시설목록 조회
  static Future<List<Place>> getPlace(String area) async {
    List<Place> places = [];

    var url = Uri.parse("${baseUrl}get_place/$area");
    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (var place in data) {
          places.add(Place.fromJson(place));
        }
      } else {
        return [];
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return []; // 예외 발생 시 빈 리스트 반환
    }
    return places;
  }

  // 2. 공연 목록 카드에서 누른 장소의 공연장 id로 공연장 찾기
  static Future<Place?> getPlaceById(String id) async {
    try {
      var url = Uri.parse("${baseUrl}get_place_by_id/$id");
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        // Check if data is not empty
        if (data != null) {
          return Place.fromJson(data);
        } else {
          return null; // 데이터가 비어있으면 null 반환
        }
      } else {
        return null;
      }
    } catch (e) {
      print("데이터를 가져오지 못했습니다: $e");
      return null; // 예외 발생 시 null 반환
    }
  }

  // 3. 검색한 텍스트로 시설목록 조회
  static Future<List<Place>> getPlaceByName(String name) async {
    List<Place> places = [];

    // URL 구성
    var url = Uri.parse("${baseUrl}get_place_by_name/$name");

    try {
      // HTTP 요청 수행
      final res = await http.get(url);

      // HTTP 상태 코드 확인
      if (res.statusCode == 200) {
        // JSON 응답을 파싱하고 'places' 리스트를 채움
        var data = jsonDecode(res.body);
        for (var place in data) {
          places.add(Place.fromJson(place));
        }
      } else {
        // 200이 아닌 상태 코드에 대해 빈 리스트 반환
        return [];
      }
    } catch (e) {
      // 예외 처리를 위해 빈 리스트를 반환
      print("데이터를 가져오지 못했습니다: $e");
      return [];
    }

    // 채워진 'places' 리스트 반환
    return places;
  }
}
