import 'package:allcon/pages/home.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:flutter/material.dart';

String searchText = '';

List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
List<String> itemContents = [
  'Item 1 Contents',
  'Item 2 Contents',
  'Item 3 Contents',
  'Item 4 Contents'
];

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
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
      appBar: MyAppBar(text: "검색"),
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
                    subtitle: Text(itemContents[index]),
                    onTap: () {
                      cardClickEvent(context, itemContents[index]);
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
