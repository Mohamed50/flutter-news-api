import 'package:flutter/material.dart';
import 'package:news_app/data/model/article.dart';

import 'article-card.dart';

class ArticlesList extends StatelessWidget {
  final List<Article> articles;
  const ArticlesList({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(8.0),
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) => ArticleCard(article: articles[index],),
      separatorBuilder: (context, index) => SizedBox(height: 8.0),
    );
  }
}
