import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:allcon/Data/Concert.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/model/performance_model.dart';

class PerformanceDetail extends StatefulWidget {
  final Performance performance;

  const PerformanceDetail({Key? key, required this.performance})
      : super(key: key);

  @override
  State<PerformanceDetail> createState() => _PerformanceDetailState();
}

class _PerformanceDetailState extends State<PerformanceDetail> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "상세 정보",
      ),
      body: InfoMain(context),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 45,
        child: FloatingActionButton(
          onPressed: () {
            // 예매처 이동
          },
          backgroundColor: Colors.purple[50],
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

  Widget InfoMain(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Stack(
                children: [
                  // 이미지 표시
                  Image.network(
                    widget.performance.poster ?? "",
                    fit: BoxFit.cover,
                  ),
                  // 불투명한 색상
                  Container(
                    color: Colors.black.withOpacity(0.5), // 투명도 조절 (0.0 - 1.0)
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.performance.name ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 28.0,
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
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.performance.poster ?? "",
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
          ],
        ),
      ),
    );
  }

  // 공연정보 + 티켓 정보 합쳐지고 , 셋리스트를 구현 안한다면 굳이 탭바가 있어야 할까요?
  /*Widget InfoTab(BuildContext context) {
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
  }*/
}

/*class ConcertInfoPage extends StatelessWidget {
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
}*/
