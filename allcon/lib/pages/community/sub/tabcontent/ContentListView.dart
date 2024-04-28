import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/Pages/Community/Sub/GetPost.dart';
import 'package:allcon/Pages/Community/controller/content_controller.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyContentListView extends StatefulWidget {
  final int tabIdx;
  final String title;
  final String searchText;
  final ContentController contentController;

  const MyContentListView({
    super.key,
    required this.tabIdx,
    required this.contentController,
    this.title = '',
    this.searchText = '',
  });

  @override
  State<MyContentListView> createState() => _MyContentListViewState();
}

class _MyContentListViewState extends State<MyContentListView> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // initState 대신 build 메서드 외부에서 초기화
      widget.contentController
          .setContentList(contentsamples[widget.tabIdx].content);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Obx(() => ListView.builder(
              itemCount: widget.contentController.contents.length,
              itemBuilder: (context, index) {
                return _buildContentItem(
                    context, widget.contentController.contents[index], index);
              },
              scrollDirection: Axis.vertical,
            )),
      ),
    );
  }

  Widget _buildContentItem(BuildContext context, Content content, int index) {
    final lowercaseSearchText = widget.searchText.toLowerCase();
    final lowercaseContent = content.content.toLowerCase();

    if (widget.searchText.isNotEmpty &&
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
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(content.date.toString());
    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(
              content: content,
              contentController: widget.contentController,
            ));
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
                            widget.contentController.contents[index].title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text(
                              widget.contentController.contents[index].writer,
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              '|',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              DateFormat('yyyy-MM-dd').format(dateTime),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
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
                                "${widget.contentController.contents[index].likeCounts}",
                                style: TextStyle(
                                  color: Colors.red[300],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Obx(
                              () => Text(
                                "${widget.contentController.contents[index].comment.length}",
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        widget.contentController.contents[index].isLike
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: widget.contentController.contents[index].isLike
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      onPressed: () {
                        widget.contentController.toggleLike(content.postId);
                        widget.contentController.update();
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
