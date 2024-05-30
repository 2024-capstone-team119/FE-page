class Relate {
  final String name;
  final String url;

  Relate({required this.name, required this.url});

  factory Relate.fromJson(Map<String, dynamic> json) {
    return Relate(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class Performance {
  final String? mid;
  final String? id;
  final String? name;
  final String? cast;
  final String? startDate;
  final String? endDate;
  final String? price;
  final String? place;
  final String? placeId;
  final String? age;
  final String? area;
  final String? visit;
  final String? state;
  final String? time;
  final String? genre;
  final String? poster;
  final List<String>? imgs;
  final String? update;
  final List<Relate>? relates;

  Performance({
    required this.mid,
    required this.id,
    required this.name,
    required this.cast,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.place,
    required this.placeId,
    required this.age,
    required this.area,
    required this.visit,
    required this.state,
    required this.time,
    required this.genre,
    required this.poster,
    required this.imgs,
    required this.update,
    this.relates,
  });

  factory Performance.fromJson(Map<String, dynamic> json) {
    return Performance(
      mid: json['_id'],
      id: json['id'],
      name: json['name'],
      cast: json['cast'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      price: json['price'],
      place: json['place'],
      placeId: json['placeId'],
      age: json['age'],
      area: json['area'],
      visit: json['visit'],
      state: json['state'],
      time: json['time'],
      genre: json['genre'],
      poster: json['poster'],
      imgs: List<String>.from(json['imgs']),
      update: json['update'],
      relates: json['relates'] != null
          ? (json['relates'] as List)
              .map((relateJson) => Relate.fromJson(relateJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': mid,
      'id': id,
      'name': name,
      'cast': cast,
      'startDate': startDate,
      'endDate': endDate,
      'price': price,
      'place': place,
      'placeId': placeId,
      'age': age,
      'area': area,
      'visit': visit,
      'state': state,
      'time': time,
      'genre': genre,
      'poster': poster,
      'imgs': imgs,
      'update': update,
      'relates': relates,
    };
  }
}
