import '../Concert.dart';

List<Concert> bannerConcertSample = [
  Concert(
    concertId: 1,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24000486_p.gif",
  ),
  Concert(
    concertId: 2,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001522_p.gif",
  ),
  Concert(
    concertId: 3,
    imgUrl:
        "https://ticketimage.interpark.com/Play/image/large/24/24001932_p.gif",
  ),
  Concert(
    concertId: 4,
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
          "https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif"),
  Concert(
      concertId: 6,
      performer: "Nell",
      title: "Nell 콘서트",
      place: "서울어딘가콘서트장",
      date: DateTime.parse('2024-02-21 18:30'),
      imgUrl:
          "http://ticketimage.interpark.com/TCMS3.0/CO/HOT/2401/240104115350_23018731.gif"),
  Concert(
      concertId: 7,
      performer: "에릭남",
      title: "에릭남; HOUSE ON A HILL",
      place: "명화라이브홀",
      date: DateTime.parse('2024-02-24 20:00'),
      imgUrl:
          "https://ticketimage.interpark.com/Play/image/large/23/23015766_p.gif"),
];
