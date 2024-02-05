import 'package:flutter/material.dart';

class SeatMain extends StatefulWidget {
  const SeatMain({super.key});

  @override
  State<SeatMain> createState() => _SeatMainState();
}

class _SeatMainState extends State<SeatMain> {
  int goodCount = 0;
  int badCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("000 공연장"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Image.network(
              'https://example.com/your_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          reviewTab(context)
        ],
      ),
    );
  }

  Widget reviewTab(BuildContext context) {
    List<String> filter = ['추천순', '최신순'];

    return Expanded(
      child: Container(
        color: Colors.purple[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (String item in filter)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 8.0, 10.0),
                      child: Text(item),
                    ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      review(context),
                      review(context),
                      review(context),
                      review(context),
                    ],
                  ),
                ),
              ),
            ],
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
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Helpful ?'),
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
}
