import 'package:allcon/model/community_model.dart';
import 'package:allcon/service/community/commentService.dart';
import 'package:allcon/service/community/likesService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetComment extends StatefulWidget {
  final Post post;
  final String userId;
  final String nickname;

  const GetComment({
    super.key,
    required this.post,
    required this.userId,
    required this.nickname,
  });

  @override
  State<GetComment> createState() => _GetCommentState();
}

class _GetCommentState extends State<GetComment> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  Comment? editingComment;
  late int likeCounts = widget.post.likesCount;

  late bool likeFuture;
  late List<Comment> commentsFuture;

  Future<List<dynamic>> fetchLikedNComment() async {
    likeFuture =
        await LikesService.isPostLiked(widget.userId, widget.post.postId);
    commentsFuture = await CommentService.getComment(widget.post.postId);
    return [likeFuture, commentsFuture];
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBottomSheet(
        context: context,
        builder: (context) => CommentInputField(context),
      );
    });
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchLikedNComment(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          bool isLike = snapshot.data![0] as bool;
          List<Comment> comments = snapshot.data![1] as List<Comment>;

          return _buildContent(isLike, comments);
        }
      },
    );
  }

  Widget _buildContent(bool isLike, List<Comment> comments) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(
                        isLike
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.redAccent),
                    onPressed: () async {
                      await LikesService.likePost(
                          widget.post.postId, widget.userId);
                      setState(() {
                        isLike ? likeCounts -= 1 : likeCounts += 1;
                      });
                    },
                  ),
                  Text(
                    '$likeCounts',
                    style: TextStyle(
                      color: Colors.red[300],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.chat_bubble,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${comments.length}',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 1.0,
          width: 450.0,
          color: Colors.grey[300],
        ),
        ListView.builder(
          reverse: true,
          primary: false, // 스크롤 설정
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            Comment comment = comments[index];
            bool isOwner = widget.userId == comment.userId;

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
                          comment.nickname,
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
                          if (isOwner)
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
                                          editComment(comment);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: const Text('삭제'),
                                        onPressed: () {
                                          Get.back();
                                          deleteComment(widget.post.postId,
                                              comment.commentId);
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
                    comment.text,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MM/dd HH:mm').format(comment.createdAt),
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
          },
        ),
      ],
    );
  }

  Widget CommentInputField(BuildContext context) {
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
                      if (editingComment != null) {
                        updateComment(
                          editingComment!,
                          _commentController.text,
                        );
                      } else {
                        addComment(_commentController.text);
                      }

                      _commentController.clear();
                      _commentFocusNode.unfocus();
                    },
                  ),
                ),
                onEditingComplete: () async {
                  if (editingComment != null) {
                    updateComment(
                      editingComment!,
                      _commentController.text,
                    );
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
                  _commentFocusNode.unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 댓글 편집
  void editComment(Comment comment) {
    setState(() {
      editingComment = comment;
      _commentController.text = comment.text;
      _commentFocusNode.requestFocus();
    });
  }

  // 댓글 수정 완료
  void updateComment(Comment comment, String updatedText) {
    if (updatedText.isNotEmpty) {
      setState(() {
        CommentService.updateComment(
            widget.post.postId, comment.commentId, updatedText);
        _commentController.clear();
      });
      setState(() {
        editingComment = null; // 수정 중인 댓글 초기화
      });
    }
  }

  // 댓글 추가 완료
  void addComment(String text) {
    if (text.isNotEmpty) {
      var newComment = {
        'userId': widget.userId,
        'nickname': widget.nickname,
        'text': text,
      };
      CommentService.addComment(widget.post.postId, newComment).then((_) {
        setState(() {});
      });
    }
  }

  // 댓글 삭제 완료
  void deleteComment(String postId, String commentId) {
    CommentService.deleteComment(postId, commentId);
    setState(() {});
  }
}
