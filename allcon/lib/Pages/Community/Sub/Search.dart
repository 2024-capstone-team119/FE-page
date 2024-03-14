import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyContentSearch extends StatefulWidget {
  final void Function(String) onSearch;

  const MyContentSearch({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<MyContentSearch> createState() => _ContentSearchState();
}

class _ContentSearchState extends State<MyContentSearch> {
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          suffixIcon: const Icon(CupertinoIcons.search),
        ),
        onChanged: (value) {
          widget.onSearch(value);
        },
      ),
    );
  }
}
