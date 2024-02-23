import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:allcon/pages/concert/concertinfo.dart' as concertinfo;
import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  String searchText = '';
  List<Concert> deadConcert = deadConcertSample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "검색",
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          searchTab(context),
          const SizedBox(
            height: 5.0,
          ),
          const Text(
            '목록',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          listTab(context),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }

  Widget searchTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          hintText: '검색어를 입력하세요.',
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
      ),
    );
  }

  Widget listTab(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: deadConcert.length,
        itemBuilder: (BuildContext context, int index) {
          final concert = deadConcert[index];
          // 검색어가 비어 있거나 검색어와 일치하는 경우에만 아이템을 표시
          if (searchText.isEmpty ||
              (concert.title != null &&
                  concert.title!
                      .toLowerCase()
                      .contains(searchText.toLowerCase())) ||
              (concert.performer != null &&
                  concert.performer!
                      .toLowerCase()
                      .contains(searchText.toLowerCase()))) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    const concertinfo.ConcertInfo(),
                    arguments: concert,
                  );
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(concert.title ?? 'unknown'),
                      subtitle: Text(concert.performer ?? 'unknown'),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: Image.network(
                          concert.imgUrl ?? '',
                          width: 50,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
