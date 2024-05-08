import 'package:allcon/Data/Sample/content_sample.dart';
import 'package:allcon/pages/community/controller/content_controller.dart';
import 'package:allcon/pages/community/sub/Update.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyContentDetail extends StatefulWidget {
  final String? category;
  final int? tabIdx;
  final Content content;
  final ContentController contentController;

  const MyContentDetail({
    super.key,
    this.category,
    this.tabIdx,
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

  // _editingComment 변수를 추가하여 수정할 댓글을 저장합니다.
  Comment? _editingComment;

  @override
  void initState() {
    super.initState();
    widget.contentController
        .setCommentList(commentsamples, widget.content.postId);
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
                                  .getContent(widget.content.postId)
                                  ?.title ??
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
                                    Get.to(MyContentUpdate(
                                      initialCategory: widget.tabIdx ?? 0,
                                      category: widget.category,
                                      originContent: widget.content,
                                      title: _contentController
                                          .getContent(widget.content.postId)!
                                          .title,
                                      content: _contentController
                                          .getContent(widget.content.postId)!
                                          .content,
                                    ));
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
                      Text(widget.content.writer),
                      const SizedBox(width: 10.0),
                      const Text('|'),
                      const SizedBox(width: 10.0),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm')
                            .format(widget.content.date),
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
                              .getContent(widget.content.postId)
                              ?.content ??
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
                                              .getContent(widget.content.postId)
                                              ?.isLike ??
                                          false
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  _contentController
                                      .toggleLike(widget.content.postId);
                                },
                              ),
                            ),
                            Obx(
                              () => Text(
                                '${_contentController.getContent(widget.content.postId)?.likeCounts ?? 0}',
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
                              '${_contentController.comments.length}',
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
                  for (int i = 0; i < _contentController.comments.length; i++)
                    commentBox(context, _contentController.comments[i], i),
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
                // 수정할 댓글이 있다면 초기값으로 설정합니다.
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요.',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      CupertinoIcons.paperplane,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      // 수정할 댓글이 있다면 해당 댓글을 수정합니다.
                      if (_editingComment != null) {
                        editComment(
                          _editingComment!,
                          _commentController.text,
                        );
                      } else {
                        addComment(_commentController.text);
                      }
                      _commentController.clear();
                      _commentFocusNode.unfocus();

                      _editingComment = null;
                    },
                  ),
                ),
                onEditingComplete: () async {
                  // 수정할 댓글이 있다면 해당 댓글을 수정합니다.
                  if (_editingComment != null) {
                    editComment(_editingComment!, _commentController.text);
                  } else {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        addComment(_commentController.text);
                        return const AlertDialog();
                      },
                    );
                  }
                  _commentController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addComment(String commentContent) {
    if (commentContent.isNotEmpty) {
      setState(() {
        // Update content controller's state
        _contentController.addComment(
          widget.content.postId,
          widget.content.commentCounts,
          commentContent,
        );
        // Clear the input field
        _commentController.clear();
      });
    }
  }

  void editComment(Comment comment, String updatedContent) {
    if (updatedContent.isNotEmpty) {
      setState(() {
        // Update content controller's state
        _contentController.updateComment(
          widget.content.postId,
          comment.commentId,
          updatedContent,
        );

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
                                Get.back();
                                // 수정할 댓글 내용을 입력 필드에 채웁니다.
                                setState(() {
                                  _editingComment = comment;
                                  _commentController.text =
                                      comment.commentContent;
                                  _commentFocusNode.requestFocus();
                                });
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
