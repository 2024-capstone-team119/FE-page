class Place {
  final String title;

  const Place(this.title);

  @override
  String toString() => title;
}

class Seoul extends Place {
  const Seoul(super.title);
}

final seoulList = [
  const Seoul('서울 공연장 1'),
  const Seoul('서울 공연장 2'),
  const Seoul('서울 공연장 3'),
  const Seoul('서울 공연장 4'),
  const Seoul('서울 공연장 5'),
];

class GyeongSang extends Place {
  const GyeongSang(super.title);
}

final gyeongSangList = [
  const GyeongSang('경상도 공연장 1'),
  const GyeongSang('경상도 공연장 2'),
  const GyeongSang('경상도 공연장 3'),
];
