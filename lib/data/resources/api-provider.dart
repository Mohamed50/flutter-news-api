import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:news_app/data/config/api-exception.dart';

/// Enum represent the REST API methods
enum Method { POST, GET, PUT, PATCH, DELETE }

/// Class to manage all the API calls
class ApiProvider {
  static const String _API_URL = baseUrl + "v2/";
  static const String baseUrl = "https://newsapi.org/";
  static const String _API_KEY = "9be37acb14cc4bbdbadddc468d80d308";

  Dio dio = Dio();

  ApiProvider() {
    initDioOptions();
  }

  /// initialize the dio base url and other configuration
  initDioOptions() async {
    dio.options.baseUrl = _API_URL;
    dio.options.connectTimeout = 10000; //10s
    dio.options.receiveTimeout = 10000; //10s
    dio.options.contentType = "application/json";
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
  }

  void close() {
    dio.close();
  }

  // ---------------------------NEWs API Calls---------------------------

  /// fetch all news api call
  Future fetchAllNews(String countryCode) async {
    return await _doRequest("top-headlines?country=$countryCode&apiKey=$_API_KEY", Method.GET, forceRefresh: true);
  }

  Future _doRequest(String path, Method method, {dynamic body, bool forceRefresh: true}) async {
    Response response;
    try {
      print("Calling API ${dio.options.baseUrl}$path");
      print("Body: $body");
      if (method == Method.POST) {
        response = await dio.post(path, data: body);
      } else if (method == Method.PUT) {
        response = await dio.put(path, data: body);
      } else if (method == Method.PATCH) {
        response = await dio.patch(path, data: body);
      } else if (method == Method.DELETE) {
        response = await dio.delete(path, data: body);
      } else if (method == Method.GET) {
        response = await dio.get(path, queryParameters: body, options: buildCacheOptions(Duration(days: 7), forceRefresh: forceRefresh));
      }
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioError catch (e) {
        handleDioError(e);
    }
  }

  dynamic returnResponse(Response response) {
    print("response:${response.data}");
    switch (response.statusCode) {
      case 200:
      case 201:
        print("response:${response.data}");
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 404:
        throw NoDataException();
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

  handleDioError(DioError e) {
    print(e);
    print(e.type);
    if(e.type == DioErrorType.other && e.message.contains("SocketException"))
      throw FetchDataException("No Internet Connection");
    else
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        break;
      default:
        switch (e.response.statusCode) {
          case 400:
            throw BadRequestException(e.response.data.toString());
          case 401:
          case 403:
            throw UnauthorisedException(e.response.data.toString());
          case 404:
            throw NoDataException();
          case 500:
          default:
            throw FetchDataException(
                'Error occurred while communication with server' +
                    ' with status code : ${e.response.statusCode}');
        }
        break;
    }
  }
}
