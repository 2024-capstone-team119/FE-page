import 'package:allcon/pages/home.dart';
import 'package:flutter/material.dart';

String searchText = '';

List<String> items = ['고척스카이돔', '두산아트센터', '디뮤지엄', '롯데콘서트홀'];

class ConcerthallSearch extends StatefulWidget {
  const ConcerthallSearch({Key? key}) : super(key: key);

  @override
  State<ConcerthallSearch> createState() => _ConcerthallSearchPageState();
}

class _ConcerthallSearchPageState extends State<ConcerthallSearch> {
  void cardClickEvent(BuildContext context, String content) {
    // You can pass 'content' or any other relevant information to the next page.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
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
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // 검색어가 비어 있거나 검색어와 일치하는 경우에만 아이템을 표시
                if (searchText.isEmpty ||
                    items[index]
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return ListTile(
                    title: Text(items[index]),
                    onTap: () {
                      cardClickEvent(context, items[index]);
                    },
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
