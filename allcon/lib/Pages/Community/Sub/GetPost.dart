import 'package:allcon/Data/Content.dart';
import 'package:allcon/Pages/Community/Home.dart';
import 'package:allcon/Pages/Community/Sub/TabContent/FreeContent.dart';
import 'package:allcon/Pages/Community/Sub/Update.dart';
import 'package:allcon/Pages/Community/Sub/content_controller.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyContentDetail extends StatefulWidget {
  final Content content;

  const MyContentDetail({Key? key, required this.content}) : super(key: key);

  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<MyContentDetail> {
  late ContentController contentController;

  TextEditingController _commentController = TextEditingController();
  FocusNode _commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    contentController = MyFreeContent().contentController;
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    super.dispose();
  }

  void toggleLike(int postId) {
    contentController.toggleLike(postId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final int like = widget.content.like ?? 0;
    final int comment = (widget.content.comment ?? []).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('커뮤니티'),
      ),
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
                      Text(
                        '${widget.content != null ? widget.content.title : "제목없음"}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
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
                                child: const Text('취소'),
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context, '취소');
                                },
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text('${widget.content.date}'),
                  SizedBox(height: 16.0),
                  Container(
                    height: 1.0,
                    width: 450.0,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${widget.content.content != null ? widget.content.content : "내용없음"}',
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                widget.content.isLike!
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                size: 30.0,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                toggleLike(widget.content.postId);
                              },
                            ),
                            Text(
                              '${like}',
                              style: TextStyle(
                                color: Colors.red[300],
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${comment}',
                              style: TextStyle(
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
                  if (widget.content.content != null &&
                      widget.content.comment != null)
                    for (int i = 0; i < widget.content.comment!.length; i++)
                      commentBox(context, widget.content.comment![i], i),
                  SizedBox(height: 65),
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
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
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
                    icon: Icon(
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
                      return AlertDialog();
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
        // Add comment to the list
        widget.content.comment!.add(comment);
        // Clear the input field
        _commentController.clear();
      });
    }
  }

  Widget commentBox(BuildContext context, String comment, int num) {
    int number = num + 1;
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
                  style: TextStyle(
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
                    child: Row(
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
            comment,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            "11/17 02:30",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 430,
            height: 0.4,
            color: Colors.grey,
          ),
          SizedBox(height: 3),
        ],
      ),
    );
  }
}
