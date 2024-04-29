import 'package:allcon/model/performance_model.dart';
import 'package:allcon/pages/concert/PerformaceDetail.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:allcon/utils/Preparing.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:allcon/service/concertService.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  String searchText = '';
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "검색",
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: ConcertService.getPerformanceByName(searchText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text('에러: ${snapshot.error}');
          } else {
            List<Performance>? searchList = snapshot.data;
            return Column(
              children: <Widget>[
                searchTab(context),
                const SizedBox(
                  height: 16.0,
                ),
                listTab(context, searchList),
              ],
            );
          }
        },
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
        controller: searchController,
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
        onEditingComplete: () {
          setState(() {
            searchText = searchController!.text;
          });
        },
      ),
    );
  }

  Widget listTab(BuildContext context, List<Performance>? searchList) {
    return searchList != null && searchList.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (BuildContext context, int index) {
                final concert = searchList[index];
                // 검색어가 비어 있거나 검색어와 일치하는 경우에만 아이템을 표시
                if ((concert.name != null &&
                        concert.name!
                            .toLowerCase()
                            .contains(searchText.toLowerCase())) ||
                    (concert.cast != null &&
                        concert.cast!
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          PerformanceDetail(performance: concert),
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              concert.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(
                              concert.cast ?? '',
                              style: const TextStyle(fontSize: 15.0),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Image.network(
                                concert.poster ?? '',
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
          )
        : const Expanded(
            child: Preparing(text: '검색 결과가 없습니다.'),
          );
  }
}
