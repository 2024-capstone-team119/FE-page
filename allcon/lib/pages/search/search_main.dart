import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:flutter/cupertino.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  String searchText = '';
  List<Concert> allConcert = allConcertSample;

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
            height: 16.0,
          ),
          /*
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
          ),*/
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
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 4.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '검색어를 입력해주세요.',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          suffixIcon: const Icon(CupertinoIcons.search),
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
        itemCount: allConcert.length,
        itemBuilder: (BuildContext context, int index) {
          final concert = allConcert[index];
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
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: GestureDetector(
                onTap: () {
                  /*Get.to(
                    const concertinfo.ConcertInfo(),
                    arguments: concert,
                  );*/
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        concert.title ?? 'unknown',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        concert.performer ?? 'unknown',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          concert.imgUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[200],
                    ),
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
