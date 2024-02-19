import 'package:flutter/material.dart';

class MyContentSearch extends StatefulWidget {
  final void Function(String) onSearchTextChanged;

  const MyContentSearch({Key? key, required this.onSearchTextChanged})
      : super(key: key);

  @override
  State<MyContentSearch> createState() => _ContentSearchState();
}

class _ContentSearchState extends State<MyContentSearch> {
  void cardClickEvent(BuildContext context, String content) {
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 4.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '검색어를 입력해주세요.',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          // 검색어가 변경될 때마다 콜백 함수 호출
          widget.onSearchTextChanged(value);
        },
      ),
    );
  }
}
