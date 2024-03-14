import 'package:allcon/Pages/Seat/seat_main.dart';
import 'package:allcon/Widget/Preparing.dart';
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
        MaterialPageRoute(builder: (context) => SeatMain(title: content)),
      );
    }

    List<Place> selectedList = [];

    // 주어진 조건에 따라 적절한 리스트 선택
    if (widget.initialTitle == '서울') {
      selectedList = seoulList;
    } else if (widget.initialTitle == '경상도') {
      selectedList = gyeongSangList;
    } else {
      return const Expanded(
        child: Preparing(text: "공연장 준비중입니다.\n 조금만 기다려주세요 :)"),
      );
    }

    // 리스트가 선택된 경우, 해당 리스트의 아이템을 표시
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
              itemCount: selectedList.length,
              itemBuilder: (BuildContext context, int index) {
                if (searchText.isEmpty ||
                    selectedList[index]
                        .title
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(selectedList[index].title),
                        onTap: () {
                          cardClickEvent(context, selectedList[index].title);
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
