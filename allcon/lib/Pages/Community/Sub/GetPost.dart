import 'package:allcon/Data/Content.dart';
import 'package:allcon/Pages/Community/controller/content_controller.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyContentDetail extends StatefulWidget {
  final RxContent content;
  final ContentController contentController;

  const MyContentDetail({
    super.key,
    required this.content,
    required this.contentController,
  });

  @override
  _ContentDetailState createState() => _ContentDetailState(contentController);
}

class _ContentDetailState extends State<MyContentDetail> {
  final ContentController _contentController;
  _ContentDetailState(this._contentController);

  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '커뮤니티'),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          _contentController
                                  .getContent(widget.content.postId.value)
                                  ?.title
                                  .value ??
                              '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext sheetContext) =>
                                CupertinoActionSheet(
                              title: const Text('옵션'),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: const Text('수정'),
                                  onPressed: () {
                                    // You can navigate to the update screen
                                    // or perform any other action as needed.
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('삭제'),
                                  onPressed: () {
                                    // You can handle content deletion
                                  },
                                ),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context, '취소');
                                },
                                child: const Text('취소'),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      Text(widget.content.writer.value),
                      const SizedBox(width: 10.0),
                      const Text('|'),
                      const SizedBox(width: 10.0),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm')
                            .format(widget.content.date.value!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 1.0,
                    width: 450.0,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Text(
                      _contentController
                              .getContent(widget.content.postId.value)
                              ?.content
                              .value ??
                          '',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => IconButton(
                                iconSize: 30.0,
                                icon: Icon(
                                  _contentController
                                              .getContent(
                                                  widget.content.postId.value)
                                              ?.isLike
                                              .value ??
                                          false
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  _contentController
                                      .toggleLike(widget.content.postId.value);
                                },
                              ),
                            ),
                            Obx(
                              () => Text(
                                '${_contentController.getContent(widget.content.postId.value)?.likeCounts ?? 0}',
                                style: TextStyle(
                                  color: Colors.red[300],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${_contentController.getContent(widget.content.postId.value)?.comment.length ?? 0}',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 450.0,
                    color: Colors.grey[300],
                  ),
                  for (int i = 0; i < widget.content.comment.length; i++)
                    commentBox(context, widget.content.comment[i], i),
                  const SizedBox(height: 65),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: CommentInputField(),
    );
  }

  Widget CommentInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                focusNode: _commentFocusNode,
                cursorColor: Colors.grey,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요.',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      CupertinoIcons.paperplane,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      addComment(_commentController.text);
                      _commentController.clear();
                      _commentFocusNode.unfocus();
                    },
                  ),
                ),
                onEditingComplete: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      addComment(_commentController.text);
                      return const AlertDialog();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addComment(String comment) {
    if (comment.isNotEmpty) {
      setState(() {
        // Update content controller's state
        _contentController.updateComment(widget.content.postId.value, comment);
        // Clear the input field
        _commentController.clear();
      });
    }
  }

  Widget commentBox(BuildContext context, Comment comment, int num) {
    int number = num + 1;
    DateTime now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  '익명$number',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              Row(
                children: [
                  Container(
                    height: 25,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 3),
                        Icon(
                          CupertinoIcons.chat_bubble,
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 3),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            comment.commentContent,
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('MM/dd HH:mm').format(now),
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 430,
            height: 0.4,
            color: Colors.grey,
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
