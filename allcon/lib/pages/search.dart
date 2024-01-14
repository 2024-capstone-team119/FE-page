import 'package:allcon/pages/home.dart';
import 'package:flutter/material.dart';

// 검색어
String searchText = '';

// 예시: 리스트뷰에 표시할 내용 -> 공연정보 리스트
List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
List<String> itemContents = [
  'Item 1 Contents',
  'Item 2 Contents',
  'Item 3 Contents',
  'Item 4 Contents'
];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void cardClickEvent(BuildContext context, int index) {
    String content; // 공연 정보
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage() //공연 정보 페이지 이동
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('검색')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: '검색어를 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              // items 변수에 저장되어 있는 모든 값 출력
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // 검색 기능, 검색어가 있을 경우
                if (searchText.isNotEmpty &&
                    !items[index]
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return const SizedBox.shrink();
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
