import 'package:allcon/Data/Content.dart';
import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/Pages/Community/controller/content_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyContentListView extends StatelessWidget {
  final int tabIdx;
  final String title;
  final String searchText;

  late ContentController _contentController;
  late List<Content> contentData;

  MyContentListView({
    required this.tabIdx,
    this.title = '',
    this.searchText = '',
  }) {
    contentData = getSampleData(tabIdx);
    _contentController = ContentController(contentData);
  }

  // 탭바의 인덱스에 맞춰 데이터 리스트를 가져옴
  List<Content> getSampleData(int index) {
    switch (index) {
      case 0:
        return ContentSamples().contentsamples[0] ?? [];
      case 1:
        return ContentSamples().contentsamples[1] ?? [];
      case 2:
        return ContentSamples().contentsamples[2] ?? [];
      case 3:
        return ContentSamples().contentsamples[3] ?? [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    _contentController = ContentController(contentData);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: _contentController.contents.length,
          itemBuilder: (context, index) {
            return _buildContentItem(
                context, _contentController.contents[index], index);
          },
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  Widget _buildContentItem(BuildContext context, Content content, int index) {
    final lowercaseSearchText = searchText.toLowerCase();
    final lowercaseContent = content.content?.toLowerCase() ?? '';

    if (searchText.isNotEmpty &&
        !lowercaseContent.contains(lowercaseSearchText)) {
      return Container();
    } else {
      return createBox(context, content, index);
    }
  }

  Widget createBox(
    BuildContext context,
    Content content,
    int index,
  ) {
    DateTime dateTime = content.date ?? DateTime.now();
    return GestureDetector(
      onTap: () {
        // Get.to(() => MyContentDetail(content: content));
      },
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
                        Obx(
                          () => Text(
                            _contentController.contents[index].title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                              color: Colors.red[300],
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Obx(
                              () => Text(
                                "${_contentController.contents[index].like}",
                                style: TextStyle(
                                  color: Colors.red[300],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Obx(
                              () => Text(
                                "${_contentController.contents[index].comment.length}",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        _contentController.contents[index].isLike
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: _contentController.contents[index].isLike
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      onPressed: () {
                        _contentController.toggleLike(content.postId);
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          Container(height: 1.0, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
