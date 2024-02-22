import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/Pages/Community/Sub/Post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/Content.dart';
import 'package:intl/intl.dart';

class MyFreeContent extends StatefulWidget {
  final String? title;
  final String searchText;
  const MyFreeContent({this.title, required this.searchText});

  @override
  State<MyFreeContent> createState() => _MyFreeContentState();
}

class _MyFreeContentState extends State<MyFreeContent> {
  List<Content> freeContents = freeContentsSample;
  List<bool> isLikesList =
      List.generate(freeContentsSample.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: freeContents.length,
          itemBuilder: (context, index) {
            return _buildContentItem(freeContents[index]);
          },
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  Widget _buildContentItem(Content content) {
    final lowercaseSearchText = widget.searchText.toLowerCase();
    final lowercaseContent = content.content?.toLowerCase() ?? '';

    if (widget.searchText.isNotEmpty &&
        !lowercaseContent.contains(lowercaseSearchText)) {
      return Container();
    } else {
      return createBox(content, freeContents.indexOf(content));
    }
  }
}

Widget createBox(Content content, int index) {
  DateTime dateTime = content.date ?? DateTime.now();
  return GestureDetector(
    onTap: () {
      Get.to(() => MyContentWrite());
    },
    child: Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              height: 80.0,
              child: Row(
                children: [
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content.content ?? "",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text(
                              "${DateFormat('yyyy-MM-dd').format(dateTime)}",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              "${DateFormat('HH:mm').format(dateTime)}",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red[300], // 원하는 색상으로 설정
                              size: 16.0, // 원하는 크기로 설정
                            ),
                            const SizedBox(width: 4.0),
                            Text("${content.like}"), // 좋아요 수 표시
                            const SizedBox(width: 8.0),
                            Icon(
                              Icons.comment,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text("${content.comments}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: const Icon(
                      // isLikesList[index] ? Icons.favorite : Icons.favorite_border,
                      // color: isLikesList[index] ? Colors.red : null,
                      Icons.favorite_outline,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   isLikesList[index] = !isLikesList[index];
                      // }
                      // );
                    },
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          Container(height: 1.0, color: Colors.grey[300]),
        ],
      ),
    ),
  );
}
