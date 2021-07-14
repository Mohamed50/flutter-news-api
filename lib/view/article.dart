import 'package:flutter/material.dart';
import 'package:news_app/config/theme.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/view/customs/time-widget.dart';
import 'package:news_app/view/customs/translatable-text.dart';
import 'package:news_app/viewModel/article-view-model.dart';
import 'package:provider/provider.dart';

import 'customs/app-bar.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<ArticleViewModel, Article>(
        selector: (_, provider) => provider.selectedArticle,
        builder: (context, article, child) => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              CustomSliverAppbar(
                title: article.title,
                imageUrl: article.urlToImage,
                heroKey: ValueKey(article.toJson()),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 16.0,),
                Row(
                  children: [
                    TranslatableText("Written by"),
                    SizedBox(width: 8.0),
                    Text(article.author, style: TextStyle(fontWeight: FontWeight.w700, color: secondaryColor),),
                    Expanded(child: SizedBox()),
                    TimeAgoText(article.publishedAt, style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.w600, color: accentColor),),
                  ],
                ),
                SizedBox(height: 24.0),
                TranslatableText("Description", style: TextStyle(fontWeight: FontWeight.w700, color: secondaryColor),),
                SizedBox(height: 8.0),
                Text(article.description, style: TextStyle(fontSize: 12.0),),
                SizedBox(height: 24.0),
                TranslatableText("Content", style: TextStyle(fontWeight: FontWeight.w700, color: secondaryColor),),
                SizedBox(height: 8.0),
                Text(article.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
