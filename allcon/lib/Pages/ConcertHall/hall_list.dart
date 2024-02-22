class Seoul {
  final String title;

  const Seoul(this.title);

  @override
  String toString() => title;
}

final seoulList = [
  const Seoul('서울 공연장 1'),
  const Seoul('서울 공연장 2'),
  const Seoul('서울 공연장 3'),
  const Seoul('서울 공연장 4'),
  const Seoul('서울 공연장 5'),
];

class GyeongSang {
  final String title;

  const GyeongSang(this.title);

  @override
  String toString() => title;
}

final gyeongSangList = [
  const GyeongSang('경상도 공연장 1'),
  const GyeongSang('경상도 공연장 2'),
  const GyeongSang('경상도 공연장 3'),
];
