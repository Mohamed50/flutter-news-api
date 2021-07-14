import 'package:news_app/data/model/article.dart';
import 'package:news_app/data/resources/api_provider.dart';

/// a class handle the articles data fetching, saving, parsing, or sending to server
class ArticleService{
  ApiProvider _apiProvider = ApiProvider();


  /// a method to fetch all articles from the news api and parse response to article model
  ///
  /// receive a countryCode => country code for the country you want to receive news about
  /// return List of article model if found else will throw an exception
  Future<List<Article>> fetchAllAnnouncement(String countryCode) async{
    dynamic response = await _apiProvider.fetchAllNews(countryCode);
    return NewsResponse.fromJson(response).articles;
  }



}