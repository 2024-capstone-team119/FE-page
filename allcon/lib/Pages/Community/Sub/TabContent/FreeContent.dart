import 'package:allcon/Data/Content.dart';
import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/Pages/Community/Sub/GetPost.dart';
import 'package:allcon/Pages/Community/Sub/content_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyFreeContent extends StatefulWidget {
  final ContentController contentController =
      ContentController(freeContentsSample);
  final String? title;
  final String searchText;

  MyFreeContent({this.title, this.searchText = ''});

  @override
  State<MyFreeContent> createState() => _MyFreeContentState();
}

class _MyFreeContentState extends State<MyFreeContent> {
  late final ContentController contentController;

  @override
  void initState() {
    super.initState();
    contentController = Get.put(ContentController(freeContentsSample));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ContentController>(
          builder: (controller) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: controller.contents.length,
                itemBuilder: (context, index) {
                  return _buildContentItem(controller.contents[index]);
                },
                scrollDirection: Axis.vertical,
              ),
            );
          },
        ));
  }

  Widget _buildContentItem(Content content) {
    final lowercaseSearchText = widget.searchText.toLowerCase();
    final lowercaseContent = content.content?.toLowerCase() ?? '';

    if (widget.searchText.isNotEmpty &&
        !lowercaseContent.contains(lowercaseSearchText)) {
      return Container();
    } else {
      return createBox(content);
    }
  }

  Widget createBox(Content content) {
    DateTime dateTime = content.date ?? DateTime.now();
    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(content: content));
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
                        Text(
                          content.title ?? "",
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
                              color: Colors.red[300],
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${content.like}",
                              style: TextStyle(
                                color: Colors.red[300],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${content.comment?.length ?? 0}",
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(
                      content.isLike
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: content.isLike ? Colors.redAccent : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.contentController.toggleLike(content.postId);
                      });
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
    );
  }
}
