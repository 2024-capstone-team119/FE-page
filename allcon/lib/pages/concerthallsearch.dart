import 'package:allcon/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:allcon/pages/seat/seat_main.dart';

String searchText = '';

List<String> items = ['고척스카이돔', '두산아트센터', '디뮤지엄', '롯데콘서트홀'];

class ConcerthallSearch extends StatefulWidget {
  final String initialTitle;

  const ConcerthallSearch({super.key, required this.initialTitle});

  @override
  State<ConcerthallSearch> createState() => _ConcerthallSearchPageState();
}

class _ConcerthallSearchPageState extends State<ConcerthallSearch> {
  void cardClickEvent(BuildContext context, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SeatMain()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '공연장',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              widget.initialTitle,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        centerTitle: true,
      ),
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
