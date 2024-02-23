import 'package:allcon/Pages/MainHome/Home.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  String searchText = '';

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
    void cardClickEvent(BuildContext context, String content) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '목록',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: deadConcertSample.length,
              itemBuilder: (BuildContext context, int index) {
                // 검색어가 비어 있거나 검색어와 일치하는 경우에만 아이템을 표시
                if (searchText.isEmpty ||
                    (deadConcertSample[index].title != null &&
                        deadConcertSample[index]
                            .title!
                            .toLowerCase()
                            .contains(searchText.toLowerCase())) ||
                    (deadConcertSample[index].performer != null &&
                        deadConcertSample[index]
                            .performer!
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))) {
                  return Column(
                    children: [
                      ListTile(
                        title:
                            Text(deadConcertSample[index].title ?? 'unknown'),
                        subtitle: Text(
                            deadConcertSample[index].performer ?? 'unknown'),
                        onTap: () {
                          cardClickEvent(context,
                              deadConcertSample[index].title ?? 'unknown');
                        },
                        leading: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.deepPurple,
                            ),
                            width: 5.0,
                            height: 30.0,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        child: Divider(),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
