import 'package:allcon/Pages/Seat/seat_main.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/Pages/ConcertHall/hall_list.dart';

class HallSearch extends StatefulWidget {
  final String initialTitle;

  const HallSearch({super.key, required this.initialTitle});

  @override
  State<HallSearch> createState() => _HallSearchPageState();
}

class _HallSearchPageState extends State<HallSearch> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: '${widget.initialTitle} 공연장'),
      body: Column(
        children: <Widget>[
          searchTab(context),
          listTab(context),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
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
        MaterialPageRoute(builder: (context) => const SeatMain()),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: seoulList.length,
        itemBuilder: (BuildContext context, int index) {
          // 검색어가 비어 있거나 검색어와 일치하는 경우에만 아이템을 표시
          if (searchText.isEmpty ||
              seoulList[index]
                  .title
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) {
            return ListTile(
              title: Text(seoulList[index].title),
              onTap: () {
                cardClickEvent(context, seoulList[index].title);
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
