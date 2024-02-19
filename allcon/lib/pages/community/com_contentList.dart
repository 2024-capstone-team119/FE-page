import 'package:allcon/pages/community/com_content.dart';
import 'package:allcon/pages/community/com_review.dart';
import 'package:flutter/material.dart';

class MyContentList extends StatefulWidget {
  final int tabIndex;
  final String searchText;

  const MyContentList({
    Key? key,
    required this.tabIndex,
    required this.searchText,
  }) : super(key: key);

  @override
  State<MyContentList> createState() => _ContentListState();
}

class _ContentListState extends State<MyContentList> {
  List<Content> contents = [];

  @override
  void initState() {
    super.initState();
    loadContents();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: contents.length,
        itemBuilder: (context, index) {
          return _buildContentItem(contents[index]);
        },
      ),
    );
  }

  Widget _buildContentItem(Content content) {
    if (content.title.toLowerCase().contains(widget.searchText.toLowerCase())) {
      return Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(content.title),
          subtitle: Text('${content.userName} • ${content.date}'),
          trailing: IconButton(
            icon: Icon(
              content.isLike ? Icons.favorite : Icons.favorite_outline,
              color: content.isLike ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                content.isLike = !content.isLike;
              });
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyContentDetail(article: content),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  void loadContents() {
    switch (widget.tabIndex) {
      case 0:
        contents = [
          Content(title: '글 제목 1', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 2', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 3', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 4', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 5', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 6', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 7', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 8', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 9', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 10', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 11', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 12', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 13', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '글 제목 14', userName: '작성자 2', date: '2022-01-02'),
          Content(title: '글 제목 15', userName: '작성자 1', date: '2022-01-01'),
          Content(title: '동행 1', userName: '작성자 7', date: '2022-01-07'),
          Content(title: '동행 24', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '동행 34', userName: '작성자 7', date: '2022-01-07'),
          Content(title: '토끼 2', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '강아지 1', userName: '작성자 7', date: '2022-01-07'),
          Content(title: '냐옹 3', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '왈왈', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '축구잼따', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '글 제목 마지막', userName: '작성자 2', date: '2022-01-02'),
        ];
        break;
      case 1:
        contents = [
          Content(title: '후기 1', userName: '작성자 3', date: '2022-01-01'),
          Content(title: '후기 2', userName: '작성자 4', date: '2022-01-02'),
          Content(title: '후기 3', userName: '작성자 3', date: '2022-01-03'),
          Content(title: '후기 4', userName: '작성자 4', date: '2022-01-04'),
          Content(title: '후기 5', userName: '작성자 3', date: '2022-01-05'),
          Content(title: '후기 6', userName: '작성자 4', date: '2022-01-06'),
          Content(title: '후기 7', userName: '작성자 3', date: '2022-01-07'),
          Content(title: '후기 8', userName: '작성자 4', date: '2022-01-08'),
          Content(title: '후기 9', userName: '작성자 3', date: '2022-01-09'),
          Content(title: '후기 마직막', userName: '작성자 4', date: '2022-01-10'),
        ];
        break;
      case 2:
        contents = [
          Content(title: '교환/양도 1', userName: '작성자 5', date: '2022-01-05'),
          Content(title: '급구!', userName: '작성자 6', date: '2022-01-06'),
          Content(title: '양도할 분 구해요ㅠ 2', userName: '작성자 6', date: '2022-01-06'),
        ];
        break;
      case 3:
        contents = [
          Content(title: '동행 1', userName: '작성자 7', date: '2022-01-07'),
          Content(title: '동행 24', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '동행 34', userName: '작성자 7', date: '2022-01-07'),
          Content(title: '토끼 2', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '강아지 1', userName: '작성자 7', date: '2022-01-07'),
          Content(title: '냐옹 3', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '왈왈', userName: '작성자 8', date: '2022-01-08'),
          Content(title: '축구잼따', userName: '작성자 8', date: '2022-01-08'),
          // Add more articles as needed for 카풀/동행
        ];
        break;
      default:
        contents = [];
    }
  }
}
