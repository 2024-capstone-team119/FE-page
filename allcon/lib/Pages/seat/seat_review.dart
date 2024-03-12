import 'package:allcon/Pages/Seat/seat_main.dart';

class Review {
  final int id;
  final String name;
  final int star;
  final String text;
  final String createTime;
  final int good;
  final int bad;

  Review({
    required this.id,
    required this.star,
    required this.name,
    required this.text,
    required this.good,
    required this.bad,
    required this.createTime,
  });
}

final reviewList = [
  Review(
      id: 0,
      name: 'rkdwldms42',
      star: 3,
      text:
          '29구역 7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
      good: 0,
      bad: 0,
      createTime: '2024-2-25'),
  Review(
      id: 1,
      name: 'antisdun',
      star: 4,
      text: 'A구역 12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
      good: 0,
      bad: 0,
      createTime: '2024-2-29'),
  Review(
      id: 2,
      name: 'capstone',
      star: 5,
      text: 'C구역 5열 중간에 위치한 자리입니다. 가격 대비 시야가 좋고, 음향도 좋아서 공연을 더욱 즐길 수 있었습니다.',
      good: 0,
      bad: 0,
      createTime: '2024-3-2'),
];
