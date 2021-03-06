import 'package:flutter/material.dart';
import 'package:news_app/data/config/api-response.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/data/services/article-service.dart';

class ArticleViewModel with ChangeNotifier{
  ArticleService articleService;

  List<Article> _articles;
  List<Article> get articles => _articles;

  ApiResponse _apiResponse  = ApiResponse.initial("no data");
  ApiResponse get apiResponse => _apiResponse;

  Article _selectedArticle;
  Article get selectedArticle => _selectedArticle;

  ArticleViewModel(){
    articleService = ArticleService();
    fetchAllArticles();
  }

  /// fetch the articles from resource and notify the UI with api call state
  Future<void> fetchAllArticles() async {
    _apiResponse = ApiResponse.loading("fetching articles");
    notifyListeners();
    try {
      _articles = await articleService.fetchAllAnnouncement("US");
      _apiResponse = ApiResponse.completed(articles);
    }
    catch (e){
      print(e.toString());
      _apiResponse = ApiResponse.error(e.toString(), exception: e);
    }
    notifyListeners();
  }

  void selectArticle(Article article){
    _selectedArticle = article;
    notifyListeners();
  }



}