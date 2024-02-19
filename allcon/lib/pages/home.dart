import 'package:allcon/pages/concertinfo.dart' as concertinfo;
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:allcon/pages/concerthallsearch.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key});

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
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: const SingleChildScrollView(
        child: HomePage(),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}

final List<String> imgList = [
  "https://ticketimage.interpark.com/Play/image/large/24/24000486_p.gif",
  'https://ticketimage.interpark.com/Play/image/large/24/24001522_p.gif',
  "https://ticketimage.interpark.com/Play/image/large/24/24001932_p.gif",
  "https://ticketimage.interpark.com/Play/image/large/24/24000706_p.gif",
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 15.0),
        _pageOfTop(),
        const SizedBox(height: 20.0),
        Container(
          height: 0.5,
          width: MediaQuery.of(context).size.width * 0.7,
          color: Colors.grey.withOpacity(0.5),
        ),
        _ConcertHallCateogory(context),
        const SizedBox(height: 15.0),
        Container(
          height: 8.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
        ),
        const SizedBox(height: 25.0),
        Text(
          '마감임박!',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        _DeadLineCon(context),
        const SizedBox(height: 30.0),
        copyRightAllCon(),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

Widget _pageOfTop() {
  return Container(
    height: 450,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Swiper(
        pagination: const SwiperPagination(),
        itemCount: imgList.length,
        viewportFraction: 0.8,
        scale: 0.8,
        autoplay: true,
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.network(
              imgList[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    ),
  );
}

Widget _DeadLineCon(BuildContext context) {
  List<Concert> concerts = [
    Concert(
      imageUrl:
          'https://ticketimage.interpark.com/Play/image/large/23/23016540_p.gif',
      name: '콘서트 1',
      time: '2024-02-20 19:00',
      venue: '공연장 1',
    ),
    Concert(
      imageUrl:
          'http://ticketimage.interpark.com/TCMS3.0/CO/HOT/2401/240104115350_23018731.gif',
      name: '콘서트 2',
      time: '2024-02-21 18:30',
      venue: '공연장 2',
    ),
    Concert(
      imageUrl:
          'https://ticketimage.interpark.com/Play/image/large/23/23015766_p.gif',
      name: '콘서트 3',
      time: '2024-02-22 20:00',
      venue: '공연장 3',
    ),
  ];
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(concerts.length, (index) {
        Concert concert = concerts[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => concertinfo.ConcertInfo(),
                ),
              );
            },
            child: Card(
              elevation: 3.5,
              // color: Color(0xFFF1EFF7),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      concert.imageUrl,
                      height: 160.0,
                      width: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12.0),
                        Text(
                          concert.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '시간: ${concert.time}',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '장소: ${concert.venue}',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}

class Concert {
  final String imageUrl;
  final String name;
  final String time;
  final String venue;

  Concert({
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.venue,
  });
}

Widget _ConcertHallCateogory(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: const Text(
            '공연장',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConcerthallSearch(
                    initialTitle: cell,
                  ),
                ),
              );
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
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Align(
      alignment: Alignment.center,
      child: const Text(
        'ⓒ 2024. (ALLCON) all rights reserved.',
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
