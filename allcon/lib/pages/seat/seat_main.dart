import 'package:flutter/material.dart';
import 'package:allcon/pages/seat/seat_write.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:allcon/Pages/Seat/seat_review.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class ReviewController extends GetxController {
  RxMap<int, int> goodCounts = <int, int>{}.obs;
  RxMap<int, int> badCounts = <int, int>{}.obs;

  void incrementGoodCount(int index) {
    goodCounts[index] = (goodCounts[index] ?? 0) + 1;
  }

  void incrementBadCount(int index) {
    badCounts[index] = (badCounts[index] ?? 0) + 1;
  }
}

class SeatMain extends StatefulWidget {
  final String title;

  const SeatMain({super.key, required this.title});

  @override
  State<SeatMain> createState() => _SeatMainState();
}

class _SeatMainState extends State<SeatMain> {
  late final ReviewController _reviewController;

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
  }

  bool recommend = false;
  bool reviewWrite = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      init: ReviewController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          bottomNavigationBar: const MyBottomNavigationBar(
            currentIndex: 1,
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: Image.network(
                  'https://example.com/your_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              reviewWrite ? reviewTab(context) : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget reviewTab(BuildContext context) {
    // 추천순, 최신순 정렬
    List<int> sortedIndexes;
    if (recommend) {
      sortedIndexes = reviewList
          .asMap()
          .entries
          .toList()
          .reversed
          .map((entry) => entry.key)
          .toList();
      sortedIndexes.sort((a, b) => (_reviewController.goodCounts[b] ?? 0)
          .compareTo(_reviewController.goodCounts[a] ?? 0));
    } else {
      sortedIndexes = List.generate(reviewList.length, (index) => index)
          .toList()
          .reversed
          .toList();
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _showModalSheet(context);
                        });
                      },
                      child: const Text(
                        '리뷰 작성하기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              recommend = true;
                            });
                          },
                          child: Text(
                            '추천순',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  recommend ? Colors.deepPurple : Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              recommend = false;
                            });
                          },
                          child: Text(
                            '최신순',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  recommend ? Colors.black : Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: List.generate(sortedIndexes.length,
                      (index) => review(context, sortedIndexes[index])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget review(BuildContext context, int index) {
    List<Widget> starIcons = [];
    for (int i = 0; i < 5; i++) {
      if (i < reviewList[index].star) {
        starIcons
            .add(const Icon(CupertinoIcons.star_fill, color: Colors.yellow));
      } else {
        starIcons.add(const Icon(CupertinoIcons.star, color: Colors.black12));
      }
    }

    int? goodCount = _reviewController.goodCounts[index];
    int? badCount = _reviewController.badCounts[index];

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reviewList[index].name),
                Row(
                  children: starIcons,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(reviewList[index].text),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Helpful ?'),
                    const SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _reviewController.goodCounts[index] =
                              (goodCount ?? 0) + 1;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good (${goodCount ?? 0})',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _reviewController.badCounts[index] =
                              (badCount ?? 0) + 1;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(
                        'Bad (${badCount ?? 0})',
                      ),
                    ),
                  ],
                ),
                Text(reviewList[index].createTime),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SeatWrite();
      },
    );
  }
}
