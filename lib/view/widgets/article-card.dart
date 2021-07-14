import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/view/customs/customs-container.dart';
import 'package:news_app/viewModel/article-view-model.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<ArticleViewModel>(context, listen: false).selectArticle(article);
        Navigator.of(context).pushNamed(articleRoute);
      },
      child: AspectRatio(
        aspectRatio: 2/1,
        child: Hero(
          tag: ValueKey(article.toJson()),
          child: CardContainer(
            padding: EdgeInsets.all(8.0),
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: CachedNetworkImageProvider(article.urlToImage ?? ""),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.black87,
                Colors.black54,
                Colors.black45,
                Colors.black38,
                Colors.black26,
                Colors.black12,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title ?? "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),maxLines: 2,),
                Text(article.author ?? "", style: TextStyle(color: Colors.white, fontSize: 12.0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
