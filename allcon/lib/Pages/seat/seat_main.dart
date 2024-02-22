import 'package:flutter/material.dart';
import 'package:allcon/pages/seat/seat_write.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';

class SeatMain extends StatefulWidget {
  const SeatMain({super.key});

  @override
  State<SeatMain> createState() => _SeatMainState();
}

class _SeatMainState extends State<SeatMain> {
  int goodCount = 0;
  int badCount = 0;
  bool reviewWrite = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("000 공연장"),
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
    bool recommend = true;

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
                  children: [
                    review(context),
                    review(context),
                    review(context),
                    review(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget review(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Container(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("name"),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Icon(Icons.star_border),
                    Icon(Icons.star_border),
                    Icon(Icons.star_border),
                    Icon(Icons.star_border),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "29구역 7열 오른쪽에 위치한 자리입니다. 예상보다 시야 좋았고, 브루노는 엄청나게 잘 보이지는 않지만 형체는 볼 수 있는 정도(?) 전광판으로도 충분했어요~~",
            ),
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
                          goodCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good ($goodCount)',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          badCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(
                        'Bad ($badCount)',
                      ),
                    ),
                  ],
                ),
                const Text('Feb 05, 2024'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 하단 모달창 함수
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
