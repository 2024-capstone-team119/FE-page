import 'package:flutter/material.dart';
import 'package:allcon/pages/seat/seat_write.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:allcon/Pages/Seat/seat_review.dart';

class SeatMain extends StatefulWidget {
  final String title;

  const SeatMain({super.key, required this.title});

  @override
  State<SeatMain> createState() => _SeatMainState();
}

class _SeatMainState extends State<SeatMain> {
  Map<int, int> goodCounts = {};
  Map<int, int> badCounts = {};
  bool recommend = true;
  bool reviewWrite = true;

  @override
  Widget build(BuildContext context) {
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
  }

  Widget reviewTab(BuildContext context) {
    // 각 리뷰를 goodCounts를 기준으로 정렬
    List<int> sortedIndexes = reviewList.asMap().keys.toList()
      ..sort((a, b) => (goodCounts[b] ?? 0).compareTo(goodCounts[a] ?? 0));

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
        starIcons.add(const Icon(Icons.star, color: Colors.yellow));
      } else {
        starIcons.add(const Icon(Icons.star_border, color: Colors.grey));
      }
    }

    int? goodCount = goodCounts[index];
    int? badCount = badCounts[index];

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Container(
        child: Column(
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
                          goodCounts[index] = (goodCount ?? 0) + 1;
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
                          badCounts[index] = (badCount ?? 0) + 1;
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
