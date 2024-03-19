import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:allcon/Data/Concert.dart';
import 'package:flutter/cupertino.dart';

class ConcertInfo extends StatefulWidget {
  const ConcertInfo({super.key});

  @override
  _ConcertInfoState createState() => _ConcertInfoState();
}

class _ConcertInfoState extends State<ConcertInfo> {
  bool isFavorite = false;
  Color? buttonColor = Colors.purple[50];
  var concert = Get.arguments as Concert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "상세 정보",
      ),
      body: infoMain(context),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 42,
        child: FloatingActionButton(
          onPressed: () {
            // 예매처 이동
          },
          backgroundColor: buttonColor,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '예매하기',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      concert.title ?? 'unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 28.0,
                    icon: Icon(
                      isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: isFavorite ? Colors.redAccent : Colors.black54,
                    ),
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      concert.imgUrl ?? '',
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('공연자 : ${concert.performer ?? 'unknown'}'),
                          Text(
                            '장소 : ${concert.place ?? 'unknown'}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            '기간 : ${DateFormat('yyyy-MM-dd HH:mm').format(concert.date!)}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            '관람 연령 : 만 ${concert.age} 세 이상',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            '관람 시간 : 총 ${concert.time} 분',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const Text(
                            '예매처 : 인터파크',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(color: Colors.grey, thickness: 0.5),
              SizedBox(
                height: 200, // 적절한 높이 조정
                child: infoTab(context),
              ),
            ],
          ),
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
              indicatorColor: Colors.deepPurple,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0, // 탭 텍스트 크기 변경
              ),
              indicatorWeight: 4,
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
