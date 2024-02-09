// community_articles.dart
import 'package:allcon/pages/community/community_review.dart';
import 'package:flutter/material.dart';

class Article {
  final String title;
  final String author;
  final String date;
  bool isLiked;
  int likes;

  Article({
    required this.title,
    required this.author,
    required this.date,
    this.isLiked = false,
    this.likes = 0,
  });

  void toggleLike() {
    isLiked = !isLiked;
    if (isLiked) {
      likes++;
    } else {
      likes--;
      if (likes < 0) likes = 0;
    }
  }
}

class CommuArticles extends StatefulWidget {
  final int tabIndex;
  final String searchText;

  const CommuArticles({
    Key? key,
    required this.tabIndex,
    required this.searchText,
  }) : super(key: key);

  @override
  State<CommuArticles> createState() => _CommuArticlesState();
}

class _CommuArticlesState extends State<CommuArticles> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return _buildArticleItem(articles[index]);
      },
    );
  }

  Widget _buildArticleItem(Article article) {
    if (article.title.toLowerCase().contains(widget.searchText.toLowerCase())) {
      return Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(article.title),
          subtitle: Text('${article.author} • ${article.date}'),
          trailing: IconButton(
            icon: Icon(
              article.isLiked ? Icons.favorite : Icons.favorite_outline,
              color: article.isLiked ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                article.toggleLike();
              });
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetail(article: article),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  void loadArticles() {
    switch (widget.tabIndex) {
      case 0:
        articles = [
          Article(title: '글 제목 1', author: '작성자 1', date: '2022-01-01'),
          Article(title: '글 제목 2', author: '작성자 2', date: '2022-01-02'),
          Article(title: '글 제목 1', author: '작성자 1', date: '2022-01-01'),
          Article(title: '글 제목 2', author: '작성자 2', date: '2022-01-02'),
          // Add more articles as needed for 자유게시판
        ];
        break;
      case 1:
        articles = [
          Article(title: '후기 1', author: '작성자 3', date: '2022-01-01'),
          Article(title: '후기 2', author: '작성자 4', date: '2022-01-02'),
          Article(title: '후기 1', author: '작성자 3', date: '2022-01-03'),
          Article(title: '후기 2', author: '작성자 4', date: '2022-01-04'),
          Article(title: '후기 1', author: '작성자 3', date: '2022-01-05'),
          Article(title: '후기 2', author: '작성자 4', date: '2022-01-06'),
          Article(title: '후기 1', author: '작성자 3', date: '2022-01-07'),
          Article(title: '후기 2', author: '작성자 4', date: '2022-01-08'),
          Article(title: '후기 1', author: '작성자 3', date: '2022-01-09'),
          Article(title: '후기 2', author: '작성자 4', date: '2022-01-10'),
          // Add more articles as needed for 공연후기
        ];
        break;
      case 2:
        articles = [
          Article(title: '교환/양도 1', author: '작성자 5', date: '2022-01-05'),
          Article(title: '급구!', author: '작성자 6', date: '2022-01-06'),
          Article(title: '양도할 분 구해요ㅠ 2', author: '작성자 6', date: '2022-01-06'),
          // Add more articles as needed for 교환/양도
        ];
        break;
      case 3:
        articles = [
          Article(title: '동행 1', author: '작성자 7', date: '2022-01-07'),
          Article(title: '동행 24', author: '작성자 8', date: '2022-01-08'),
          Article(title: '동행 34', author: '작성자 7', date: '2022-01-07'),
          Article(title: '토끼 2', author: '작성자 8', date: '2022-01-08'),
          Article(title: '강아지 1', author: '작성자 7', date: '2022-01-07'),
          Article(title: '냐옹 3', author: '작성자 8', date: '2022-01-08'),
          Article(title: '왈왈', author: '작성자 8', date: '2022-01-08'),
          Article(title: '축구잼따', author: '작성자 8', date: '2022-01-08'),
          // Add more articles as needed for 카풀/동행
        ];
        break;
      default:
        articles = [];
    }
  }
}
