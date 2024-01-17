import 'package:allcon/pages/concertinfo.dart'
    as concertinfo; // concertinfo로 변경
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '/widget/app_bar.dart';
import '/widget/bottom_navigation_bar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // 로케일 데이터 초기화
  await initializeDateFormatting();

  // 앱을 시작하는 나머지 코드
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _idx = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: const SingleChildScrollView(
        child: HomePage(),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _idx,
        onTap: (index) {
          setState(() {
            _idx = index;
          });
        },
      ),
    );
  }
}

final List<String> imgList = [
  'https://example.com/image1.jpg',
  'https://example.com/image2.jpg',
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _pageOfTop(),
        const SizedBox(height: 15.0),
        _pageOfMiddle(context),
        const SizedBox(height: 15.0),
        _pageOfBottom(context),
        const SizedBox(height: 15.0),
        copyRightAllCon(),
      ],
    );
  }
}

Widget _pageOfTop() {
  return Container(
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Swiper(
        pagination: const SwiperPagination(),
        itemCount: imgList.length,
        viewportFraction: 0.8,
        scale: 0.85,
        autoplay: true,
        autoplayDelay: 5000,
        autoplayDisableOnInteraction: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            imgList[index],
            fit: BoxFit.fill,
          );
        },
      ),
    ),
  );
}

Widget _pageOfMiddle(BuildContext context) {
  List<String> imageUrls = [
    'https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif',
    'http://ticketimage.interpark.com/TCMS3.0/CO/HOT/2401/240104115350_23018731.gif',
    'https://ticketimage.interpark.com/Play/image/large/23/23015766_p.gif',
  ];

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '마감임박',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(height: 10.0),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const concertinfo
                          .ConcertInfo()), // 수정: concertinfo로 변경
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _pageOfBottom(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '공연장',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16.0),
        Table(
          border: TableBorder.all(),
          children: [
            buildRow(context, ['서울', '경기도/인천', '강원도']),
            buildRow(context, ['충청도', '경상도', '전라도']),
          ],
        ),
      ],
    ),
  );
}

TableRow buildRow(BuildContext context, List<String> cells) {
  return TableRow(
    children: cells
        .map(
          (cell) => InkWell(
            onTap: () {
              print('Clicked on cell: $cell');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        )
        .toList(),
  );
}

Widget copyRightAllCon() {
  return Container(
    padding: const EdgeInsets.all(15.0),
    child: const Text(
      'ⓒ 2024. (ALLCON) all rights reserved.',
      style: TextStyle(
        fontSize: 10.0,
        color: Colors.grey,
      ),
    ),
  );
}
