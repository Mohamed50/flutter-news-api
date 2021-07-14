import 'package:flutter/material.dart';
import 'package:news_app/data/config/api-response.dart';
import 'package:news_app/view/customs/api-response-handler.dart';
import 'package:news_app/view/widgets/articles-list.dart';
import 'package:news_app/viewModel/article-view-model.dart';
import 'package:provider/provider.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ArticleViewModel, ApiResponse>(
      selector: (_, provider) => provider.apiResponse,
      builder: (context, apiResponse, child) => ApiResponseHandler(
        apiResponse: apiResponse,
        completed: ArticlesList(
          articles: apiResponse.data,
        ),
        tryAgain: Provider.of<ArticleViewModel>(context, listen: false).fetchAllArticles,
      ),
    );
  }
}
