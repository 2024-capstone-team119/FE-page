import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import './community_articels.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;

  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  int _currentIndex = 3;
  List<String> commentsList = [];
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '커뮤니티',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.article.title}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    children: [
                      Text('${widget.article.author}'),
                      SizedBox(width: 15.0),
                      Text('${widget.article.date}'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 1.0,
                    width: 450.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 600,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  widget.article.toggleLike();
                                });
                              },
                              color: widget.article.isLiked ? Colors.red : null,
                            ),
                            Text('${widget.article.likes}'),
                            SizedBox(width: 15),
                            Icon(Icons.comment),
                            SizedBox(width: 10),
                            Text('${commentsList.length}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 450.0,
                    color: Colors.red,
                  ),
                  _buildCommentList(),
                  SizedBox(height: 65),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomSheet: _buildCommentInput(),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요.',
                  border: InputBorder.none,
                ),
                onChanged: (comment) {
                  // 댓글이 변경될 때의 처리 (필요한 경우)
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send_outlined),
              onPressed: () {
                setState(() {
                  String comment = _commentController.text;
                  if (comment.isNotEmpty) {
                    commentsList.add(comment);
                    _commentController.clear();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: commentsList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(commentsList[index]),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}
