import 'package:flutter/material.dart';
import './community_articels.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Author: ${article.author}'),
            Text('Date: ${article.date}'),
            // 여기에 필요한 다른 정보 표시
          ],
        ),
      ),
    );
  }
}
