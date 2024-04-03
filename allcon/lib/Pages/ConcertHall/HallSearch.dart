import 'package:allcon/Pages/ConcertHall/HallMain.dart';
import 'package:flutter/material.dart';
import 'package:allcon/model/place_model.dart';
import 'package:allcon/service/api.dart';
import 'package:allcon/Util/Loading.dart';
import 'package:allcon/Widget/Preparing.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';

class HallSearch extends StatefulWidget {
  final String area;

  const HallSearch({super.key, required this.area});

  @override
  State<HallSearch> createState() => _HallSearchPageState();
}

class _HallSearchPageState extends State<HallSearch> {
  late final TextEditingController _textEditingController =
      TextEditingController();
  String searchText = '';
  late final Future<List<Place>> _futurePlaces = Api.getPlace(widget.area);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: '${widget.area} 공연장'),
      body: FutureBuilder(
          future: _futurePlaces, // FutureBuilder의 future에 변수 할당
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Text('에러: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Preparing(text: '공연장 준비중입니다.\n 조금만 기다려주세요 :)');
            } else {
              List<Place> selectedList = snapshot.data!;

              return Column(
                children: <Widget>[
                  searchTab(context),
                  const SizedBox(height: 16.0),
                  listTab(context, selectedList),
                ],
              );
            }
          }),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }

  Widget searchTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 4.0),
      child: TextField(
        controller: _textEditingController,
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

  Widget listTab(BuildContext context, List<Place> selectedList) {
    void cardClickEvent(BuildContext context, String content) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HallMain(title: content)),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedList.length,
              itemBuilder: (BuildContext context, int index) {
                if (searchText.isEmpty ||
                    selectedList[index]
                        .name!
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(selectedList[index].name!),
                        onTap: () {
                          cardClickEvent(context, selectedList[index].name!);
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
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
