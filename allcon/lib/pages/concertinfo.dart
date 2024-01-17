import 'package:flutter/material.dart';

class ConcertInfo extends StatefulWidget {
  const ConcertInfo({super.key});

  @override
  State<ConcertInfo> createState() => _ConcertInfoState();
}

class _ConcertInfoState extends State<ConcertInfo> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("공연"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child: Row(
                      children: [
                        Container(
                          child: const Text(
                            '2023 적재 콘서트 〈Farewell〉',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isFavorite ? Colors.red : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      child: Divider(color: Colors.grey, thickness: 0.5)),
                  Row(
                    children: [
                      Image.network(
                        'https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif',
                        width: 150,
                        height: 150,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '장소: 블루스퀘어 마스터카드홀',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            '공연 기간: 2023.12.22 ~ 25',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            '관람 연령: 만 8세 이상',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            '관람 시간: 총 100분',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            '예매처: 인터파크',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    child: Divider(color: Colors.grey, thickness: 0.5),
                  ),
                  SizedBox(
                    height: 200, // 적절한 높이 조정
                    child: infoTab(context),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // 예매처 이동
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  fixedSize: const Size(50.0, 30.0)),
              child: const Text('예매하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class ConcertInfoPage extends StatelessWidget {
  final String content;

  const ConcertInfoPage(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

Widget infoTab(BuildContext context) {
  return const DefaultTabController(
    length: 3,
    child: Scaffold(
      body: Column(
        children: [
          TabBar(
            indicatorColor: Colors.black,
            labelStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            indicatorWeight: 3,
            tabs: [
              Tab(
                text: '공연 정보',
                height: 30,
              ),
              Tab(
                text: '티켓 정보',
                height: 30,
              ),
              Tab(
                text: '셋리스트',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ConcertInfoPage('공연 정보 페이지'),
                ConcertInfoPage('티켓 정보 페이지'),
                ConcertInfoPage('셋리스트 페이지'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
