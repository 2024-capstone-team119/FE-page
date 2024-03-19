import '../Concert.dart';

List<Concert> allConcertSample = [
  Concert(
    concertId: 1,
    performer: "김종구, 조성윤, 안재영 등",
    title: "뮤지컬 〈디아길레프〉",
    place: "예스24아트원 1관(구 아트원씨어터)",
    date: DateTime.parse('2024-04-09 20:00'),
    age: 14,
    time: 100,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000486_p.gif",
  ),
  Concert(
    concertId: 2,
    performer: "우미",
    title: "우미 (UMI) 내한공연",
    place: "명화 라이브 홀",
    date: DateTime.parse('2024-04-09 20:00'),
    age: 12,
    time: 80,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001522_p.gif",
  ),
  Concert(
    concertId: 3,
    performer: "케니 지",
    title: "2024 케니 지(Kenny G) 월드투어 내한공연 - 서울",
    place: "경희대학교 평화의전당",
    date: DateTime.parse('2024-04-13 18:00'),
    age: 8,
    time: 90,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001932_p.gif",
  ),
  Concert(
    concertId: 4,
    performer: "슬로우다이브",
    title: "슬로우다이브 내한공연",
    place: "명화 라이브 홀",
    date: DateTime.parse('2024-03-09 19:00'),
    age: 12,
    time: 90,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000706_p.gif",
  ),
  Concert(
    concertId: 5,
    performer: "적재",
    title: "2023 적재 콘서트 : Farewell",
    place: "블루스퀘어홀",
    date: DateTime.parse('2024-02-20 19:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif",
    age: 12,
    time: 120,
  ),
  Concert(
    concertId: 6,
    performer: "Nell",
    title: "Nell 콘서트",
    place: "서울어딘가콘서트장",
    date: DateTime.parse('2024-02-21 18:30'),
    imgUrl:
        "http://ticketimage.interpark.com/TCMS3.0/CO/HOT/2401/240104115350_23018731.gif",
    age: 18,
    time: 150,
  ),
  Concert(
    concertId: 7,
    performer: "에릭남",
    title: "에릭남; HOUSE ON A HILL",
    place: "명화라이브홀",
    date: DateTime.parse('2024-02-24 20:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/23/23015766_p.gif",
    age: 8,
    time: 100,
  ),
  Concert(
    concertId: 8,
    performer: "MAX",
    title: "맥스 내한공연 (MAX Live in Seoul)",
    place: "명화라이브홀",
    date: DateTime.parse('2024-03-30 19:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000829_p.gif",
    age: 12,
    time: 80,
  ),
  Concert(
    concertId: 9,
    performer: "RADWIMPS",
    title:
        "RADWIMPS WORLD TOUR 2024 “The way you yawn, and the outcry of Peace” in Seoul",
    place: "SK올림픽핸드볼경기장",
    date: DateTime.parse('2024-02-25 19:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001692_p.gif",
    age: 8,
    time: 120,
  ),
  Concert(
    concertId: 10,
    performer: "노엘 갤러거",
    title: "노엘 갤러거 하이 플라잉 버즈",
    place: "일산 킨텍스 제1전시장 1, 2홀",
    date: DateTime.parse('2024-07-26 20:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24003561_p.gif",
    age: 12,
    time: 100,
  ),
];

List<Concert> bannerConcertSample = [
  Concert(
    concertId: 1,
    performer: "김종구, 조성윤, 안재영 등",
    title: "뮤지컬 〈디아길레프〉",
    place: "예스24아트원 1관(구 아트원씨어터)",
    date: DateTime.parse('2024-04-09 20:00'),
    age: 14,
    time: 100,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000486_p.gif",
  ),
  Concert(
    concertId: 2,
    performer: "우미",
    title: "우미 (UMI) 내한공연",
    place: "명화 라이브 홀",
    date: DateTime.parse('2024-04-09 20:00'),
    age: 12,
    time: 80,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001522_p.gif",
  ),
  Concert(
    concertId: 3,
    performer: "케니 지",
    title: "2024 케니 지(Kenny G) 월드투어 내한공연 - 서울",
    place: "경희대학교 평화의전당",
    date: DateTime.parse('2024-04-13 18:00'),
    age: 8,
    time: 90,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001932_p.gif",
  ),
  Concert(
    concertId: 4,
    performer: "슬로우다이브",
    title: "슬로우다이브 내한공연",
    place: "명화 라이브 홀",
    date: DateTime.parse('2024-03-09 19:00'),
    age: 12,
    time: 90,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000706_p.gif",
  ),
];

List<Concert> deadConcertSample = [
  Concert(
    concertId: 5,
    performer: "적재",
    title: "2023 적재 콘서트 : Farewell",
    place: "블루스퀘어홀",
    date: DateTime.parse('2024-02-20 19:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif",
    age: 12,
    time: 120,
  ),
  Concert(
    concertId: 6,
    performer: "Nell",
    title: "Nell 콘서트",
    place: "서울어딘가콘서트장",
    date: DateTime.parse('2024-02-21 18:30'),
    imgUrl:
        "http://ticketimage.interpark.com/TCMS3.0/CO/HOT/2401/240104115350_23018731.gif",
    age: 18,
    time: 150,
  ),
  Concert(
    concertId: 7,
    performer: "에릭남",
    title: "에릭남; HOUSE ON A HILL",
    place: "명화라이브홀",
    date: DateTime.parse('2024-02-24 20:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/23/23015766_p.gif",
    age: 8,
    time: 100,
  ),
  Concert(
    concertId: 8,
    performer: "MAX",
    title: "맥스 내한공연 (MAX Live in Seoul)",
    place: "명화라이브홀",
    date: DateTime.parse('2024-03-30 19:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000829_p.gif",
    age: 12,
    time: 80,
  ),
  Concert(
    concertId: 9,
    performer: "RADWIMPS",
    title:
        "RADWIMPS WORLD TOUR 2024 “The way you yawn, and the outcry of Peace” in Seoul",
    place: "SK올림픽핸드볼경기장",
    date: DateTime.parse('2024-02-25 19:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001692_p.gif",
    age: 8,
    time: 120,
  ),
  Concert(
    concertId: 10,
    performer: "노엘 갤러거",
    title: "노엘 갤러거 하이 플라잉 버즈",
    place: "일산 킨텍스 제1전시장 1, 2홀",
    date: DateTime.parse('2024-07-26 20:00'),
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24003561_p.gif",
    age: 12,
    time: 100,
  ),
];
