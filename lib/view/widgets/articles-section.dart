import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/config/api-response.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/view/customs/api-response-handler.dart';
import 'package:news_app/view/widgets/article-card.dart';
import 'package:news_app/viewModel/article-view-model.dart';
import 'package:provider/provider.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ArticleViewModel, ApiResponse<List<Article>>>(
      selector: (_, provider) => provider.apiResponse,
      builder: (context, apiResponse, child) => ApiResponseHandler(
        apiResponse: apiResponse,
        completed: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          physics: NeverScrollableScrollPhysics(),
          itemCount: apiResponse.data.length,
          itemBuilder: (context, index) => ArticleCard(article: apiResponse.data[index],),
          separatorBuilder: (context, index) => SizedBox(height: 8.0),
        ),
      ),
    );
  }
}
