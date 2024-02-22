import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:allcon/Pages/Calendar/calendar_main.dart';
import 'package:allcon/Pages/Concert/concertinfo.dart' as concertinfo;
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Widget/copyRight_ALLCON.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:allcon/Pages/concerthallsearch.dart';
import 'package:allcon/Data/Concert.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Concert> bannerConcert = bannerConcertSample;
  List<Concert> deadConcert = deadConcertSample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: 'ALLCON',
        textFontFamily: 'Cafe24Moyamoya',
        actions: const Icon(Icons.calendar_month),
        onActionPressed: () {
          Get.to(const Calendar());
        },
      ),
      body: const SingleChildScrollView(
        child: HomePage(),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 15.0),
        bannerConcertList(),
        const SizedBox(height: 20.0),
        Container(
          height: 0.5,
          width: MediaQuery.of(context).size.width * 0.7,
          color: Colors.grey.withOpacity(0.5),
        ),
        const SizedBox(height: 15.0),
        ConcertHallCateogory(context),
        const SizedBox(height: 25.0),
        Container(
          height: 8.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
        ),
        const SizedBox(height: 32.0),
        const Text(
          '마감임박!',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
          ),
        ),
        deadConcertList(context),
        const SizedBox(height: 30.0),
        copyRightAllCon(),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

Widget bannerConcertList() {
  return SizedBox(
    height: 450,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Swiper(
        pagination: const SwiperPagination(),
        itemCount: bannerConcertSample.length,
        viewportFraction: 0.8,
        scale: 0.8,
        autoplay: true,
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.network(
              bannerConcertSample[index].imgUrl ?? "",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    ),
  );
}

Widget deadConcertList(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(deadConcertSample.length, (index) {
        Concert concert = deadConcertSample[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Get.to(const concertinfo.ConcertInfo());
            },
            child: Card(
              elevation: 3.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      concert.imgUrl ?? "",
                      height: 160.0,
                      width: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12.0),
                          Text(
                            concert.title ?? "",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '공연일 : ${DateFormat('yyyy-MM-dd').format(concert.date!)} ${DateFormat('HH:mm').format(concert.date!)}',
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '장소 : ${concert.place}',
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
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

Widget ConcertHallCateogory(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            '공연장',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: Colors.black,
            ),
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
