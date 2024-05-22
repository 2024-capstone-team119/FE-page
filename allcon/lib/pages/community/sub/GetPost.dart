import 'package:allcon/pages/community/Home.dart';
import 'package:allcon/pages/community/sub/GetComment.dart';
import 'package:allcon/pages/community/sub/Likes.dart';
import 'package:allcon/pages/community/sub/Update.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyContentDetail extends StatefulWidget {
  final String category;
  final int tabIdx;
  final Post post;
  final String userId;
  final String nickname;
  final bool anonymous;
  final bool likeToDetail; // 이전 페이지 이동을 위한 불린

  const MyContentDetail({
    super.key,
    required this.category,
    required this.tabIdx,
    required this.post,
    required this.userId,
    required this.nickname,
    required this.anonymous,
    required this.likeToDetail,
  });

  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<MyContentDetail> {
  @override
  void initState() {
    super.initState();
  }

  void _deletePost() async {
    await PostService.deletePost(widget.post.postId);
    Get.to(() => MyCommunity(initialTabIndex: widget.tabIdx));
  }

  @override
  Widget build(BuildContext context) {
    bool isOwner = widget.userId == widget.post.userId;

    return Scaffold(
      appBar: MyAppBar(
          text: '커뮤니티',
          onLeadingPressed: () {
            Get.back(); // 댓글 팝업 닫기
            // 좋아요 목록에서 넘어왔는지 확인
            if (widget.likeToDetail == true) {
              Get.to(MyContentLikes(
                tabIdx: widget.tabIdx,
                initialCategory: widget.category,
                userId: widget.userId,
                nickname: widget.nickname,
              ));
            } else {
              Get.to(MyCommunity(initialTabIndex: widget.tabIdx));
            }
          }),
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
                      Expanded(
                        child: Text(
                          widget.post.title,
                          maxLines: 5,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      if (isOwner) // owner 인 경우에만 수정/삭제 버튼 활성화
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
                                        initialCategory: widget.tabIdx,
                                        category: widget.category,
                                        originPost: widget.post,
                                        title: widget.post.title,
                                        text: widget.post.text,
                                      ));
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('삭제'),
                                    onPressed: () {
                                      _deletePost();
                                      Navigator.pop(context, '삭제');
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
                      Text(widget.anonymous ? '익명' : widget.post.nickname),
                      const SizedBox(width: 10.0),
                      const Text('|'),
                      const SizedBox(width: 10.0),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm')
                            .format(widget.post.createdAt),
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
                  Text(
                    widget.post.text,
                  ),
                  const SizedBox(height: 20),
                  GetComment(
                    post: widget.post,
                    userId: widget.userId,
                    nickname: widget.nickname,
                    anonymous: widget.anonymous,
                  ),
                  const SizedBox(height: 65),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
