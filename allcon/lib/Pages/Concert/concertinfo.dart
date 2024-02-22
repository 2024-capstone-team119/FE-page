import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Widget/app_bar.dart';

class ConcertInfo extends StatefulWidget {
  const ConcertInfo({super.key});

  @override
  _ConcertInfoState createState() => _ConcertInfoState();
}

class _ConcertInfoState extends State<ConcertInfo> {
  bool isFavorite = false;
  Color? buttonColor = Colors.purple[50];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "공연",
        automaticallyImplyLeading: false,
      ),
      body: infoMain(context),
      floatingActionButton: SizedBox(
        width: 370,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            // 예매처 이동
          },
          backgroundColor: buttonColor,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('예매하기'),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }

  Widget infoMain(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '2023 적재 콘서트 〈Farewell〉',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
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
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
            const SizedBox(
              child: Divider(color: Colors.grey, thickness: 0.5),
            ),
            Row(
              children: [
                Image.network(
                  'https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
    );
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
                fontWeight: FontWeight.bold,
                fontSize: 14.0, // 탭 텍스트 크기 변경
              ),
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
