import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/layout/HallPreparing.dart';
import 'package:allcon/pages/review/layout/gyeonggi_incheon/Goyang_Aram.dart';
import 'package:allcon/pages/review/layout/gyeonggi_incheon/Songdo_convensia.dart';
import 'package:allcon/pages/review/layout/seoul/BlueSquareMasterCard.dart';
import 'package:allcon/pages/review/layout/seoul/OlympicChaejo.dart';
import 'package:allcon/pages/review/layout/seoul/Yes24LiveHall.dart';

final seoulHall = [
  Hall(
    hallIdx: 0,
    hallName: '블루스퀘어',
    seatingChart: const BlueSquareMasterCard(),
    zone: [
      Zone(zoneIdx: 0, zoneName: '1구역', review: [
        Review(
          reviewId: 0,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 1,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 2,
          writer: 'capstone',
          content: '스탠딩으로 관람했습니다. 공간이 널널하고 무대가 가까워서 좋았어요.',
          image: '',
          starCount: 5,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 1, zoneName: '2구역', review: [
        Review(
          reviewId: 3,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 4,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 2, zoneName: '3구역', review: []),
      Zone(zoneIdx: 3, zoneName: '4구역', review: []),
      Zone(zoneIdx: 4, zoneName: '5구역', review: []),
      Zone(zoneIdx: 5, zoneName: '6구역', review: []),
      Zone(zoneIdx: 6, zoneName: '7구역', review: []),
      Zone(zoneIdx: 7, zoneName: '8구역', review: []),
    ],
  ),
  Hall(
    hallIdx: 1,
    hallName: '올림픽공원',
    seatingChart: const OlympicChaejo(),
    zone: [
      Zone(zoneIdx: 0, zoneName: '1구역', review: [
        Review(
          reviewId: 0,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 1,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 2,
          writer: 'capstone',
          content: '스탠딩으로 관람했습니다. 공간이 널널하고 무대가 가까워서 좋았어요.',
          image: '',
          starCount: 5,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 1, zoneName: '2구역', review: [
        Review(
          reviewId: 3,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 4,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 2, zoneName: '3구역', review: []),
      Zone(zoneIdx: 3, zoneName: '4구역', review: []),
      Zone(zoneIdx: 4, zoneName: '5구역', review: []),
      Zone(zoneIdx: 5, zoneName: '6구역', review: []),
      Zone(zoneIdx: 6, zoneName: '7구역', review: []),
      Zone(zoneIdx: 7, zoneName: '8구역', review: []),
      Zone(zoneIdx: 8, zoneName: '9구역', review: []),
      Zone(zoneIdx: 9, zoneName: '10구역', review: []),
      Zone(zoneIdx: 10, zoneName: '11구역', review: []),
      Zone(zoneIdx: 11, zoneName: '12구역', review: []),
      Zone(zoneIdx: 12, zoneName: '13구역', review: []),
      Zone(zoneIdx: 13, zoneName: '14구역', review: []),
    ],
  ),
  Hall(
    hallIdx: 2,
    hallName: '예스24 라이브홀 (구. 악스코리아)',
    seatingChart: const Yes24LiveHall(),
    zone: [
      Zone(zoneIdx: 0, zoneName: 'A구역', review: [
        Review(
          reviewId: 0,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 1,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 2,
          writer: 'capstone',
          content: '스탠딩으로 관람했습니다. 공간이 널널하고 무대가 가까워서 좋았어요.',
          image: '',
          starCount: 5,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 1, zoneName: 'B구역', review: [
        Review(
          reviewId: 3,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 4,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 2, zoneName: 'C구역', review: []),
      Zone(zoneIdx: 3, zoneName: 'D구역', review: []),
      Zone(zoneIdx: 4, zoneName: 'E구역', review: []),
      Zone(zoneIdx: 5, zoneName: 'X구역', review: []),
      Zone(zoneIdx: 6, zoneName: 'Y구역', review: []),
      Zone(zoneIdx: 7, zoneName: 'Z구역', review: []),
    ],
  ),
  Hall(
    hallIdx: 3,
    hallName: '예정',
    seatingChart: const HallPreparing(),
    zone: [Zone(zoneIdx: 0, zoneName: '전체', review: [])],
  )
];

final gyeongInHall = [
  Hall(
    hallIdx: 0,
    hallName: '고양아람누리',
    seatingChart: const GoyangAram(),
    zone: [
      Zone(zoneIdx: 0, zoneName: '1구역', review: [
        Review(
          reviewId: 0,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 1,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 2,
          writer: 'capstone',
          content: '스탠딩으로 관람했습니다. 공간이 널널하고 무대가 가까워서 좋았어요.',
          image: '',
          starCount: 5,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 1, zoneName: '2구역', review: [
        Review(
          reviewId: 3,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 4,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 2, zoneName: '3구역', review: []),
      Zone(zoneIdx: 3, zoneName: '4구역', review: []),
      Zone(zoneIdx: 4, zoneName: '5구역', review: []),
      Zone(zoneIdx: 5, zoneName: '6구역', review: []),
      Zone(zoneIdx: 6, zoneName: '7구역', review: []),
      Zone(zoneIdx: 7, zoneName: '8구역', review: []),
      Zone(zoneIdx: 8, zoneName: '9구역', review: []),
      Zone(zoneIdx: 9, zoneName: '10구역', review: []),
      Zone(zoneIdx: 10, zoneName: '11구역', review: []),
      Zone(zoneIdx: 11, zoneName: '12구역', review: []),
      Zone(zoneIdx: 12, zoneName: '13구역', review: []),
      Zone(zoneIdx: 13, zoneName: '14구역', review: []),
    ],
  ),
  Hall(
    hallIdx: 1,
    hallName: '송도컨벤시아',
    seatingChart: const SongdoConvensia(),
    zone: [
      Zone(zoneIdx: 0, zoneName: '1구역', review: [
        Review(
          reviewId: 0,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 1,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 2,
          writer: 'capstone',
          content: '스탠딩으로 관람했습니다. 공간이 널널하고 무대가 가까워서 좋았어요.',
          image: '',
          starCount: 5,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 1, zoneName: '2구역', review: [
        Review(
          reviewId: 3,
          writer: 'rkdwldms42',
          content:
              '7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~',
          image: '',
          starCount: 4,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
        Review(
          reviewId: 4,
          writer: 'creamycoke',
          content:
              '12열 왼쪽에 위치한 자리입니다. 좌석이 약간 좁은 편이지만 무대 전체를 잘 볼 수 있어서 만족스럽습니다.',
          image: '',
          starCount: 3,
          goodCount: 0,
          badCount: 0,
          dateTime: DateTime.now(),
        ),
      ]),
      Zone(zoneIdx: 2, zoneName: '3구역', review: []),
      Zone(zoneIdx: 3, zoneName: '4구역', review: []),
      Zone(zoneIdx: 4, zoneName: '5구역', review: []),
      Zone(zoneIdx: 5, zoneName: '6구역', review: []),
      Zone(zoneIdx: 6, zoneName: '7구역', review: []),
      Zone(zoneIdx: 7, zoneName: '8구역', review: []),
      Zone(zoneIdx: 8, zoneName: '9구역', review: []),
      Zone(zoneIdx: 9, zoneName: '10구역', review: []),
      Zone(zoneIdx: 10, zoneName: '11구역', review: []),
      Zone(zoneIdx: 11, zoneName: '12구역', review: []),
      Zone(zoneIdx: 12, zoneName: '13구역', review: []),
      Zone(zoneIdx: 13, zoneName: '14구역', review: []),
    ],
  ),
  Hall(
    hallIdx: 2,
    hallName: '예정',
    seatingChart: const HallPreparing(),
    zone: [Zone(zoneIdx: 0, zoneName: '전체', review: [])],
  )
];

final noHall = [
  Hall(
    hallIdx: 0,
    hallName: '예정',
    seatingChart: const HallPreparing(),
    zone: [Zone(zoneIdx: 0, zoneName: '전체', review: [])],
  )
];
