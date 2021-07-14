import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:news_app/data/config/api-exception.dart';

/// Enum represent the REST API methods
enum Method { POST, GET, PUT, PATCH, DELETE }

/// Class to manage all the API calls
class ApiProvider {
  static const String _API_URL = baseUrl + "v2/";
  static const String baseUrl = "https://newsapi.org/";
  static const String _API_KEY = "9be37acb14cc4bbdbadddc468d80d308";

  final cacheOptions = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),
    // Default.
    policy: CachePolicy.request,
    // Optional. Returns a cached response on error but for statuses 401 & 403.
    hitCacheOnErrorExcept: [401, 403],
    // Optional. Overrides any HTTP directive to delete entry past this duration.
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended.
    allowPostMethod: false,
  );

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
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  void close() {
    dio.close();
  }

  // ---------------------------NEWs API Calls---------------------------

  /// fetch all news api call
  Future fetchAllNews(String countryCode) async {
    return await _doRequest(
        "top-headlines?country=$countryCode&apiKey=$_API_KEY", Method.GET);
  }

  Future _doRequest(String path, Method method,
      {dynamic body, bool forceRefresh: true}) async {
    Options options = cacheOptions.copyWith(policy: forceRefresh ? CachePolicy.refresh : CachePolicy.forceCache).toOptions();
    Response response;
    try {
      print("Calling API ${dio.options.baseUrl}$path");
      print("Body: $body");
      if (method == Method.POST) {
        response = await dio.post(path, data: body, options: options);
      } else if (method == Method.PUT) {
        response = await dio.put(path, data: body, options: options);
      } else if (method == Method.PATCH) {
        response = await dio.patch(path, data: body, options: options);
      } else if (method == Method.DELETE) {
        response = await dio.delete(path, data: body, options: options);
      } else if (method == Method.GET) {
        response = await dio.get(path, queryParameters: body, options: options);
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
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw FetchDataException("No Internet Connection");
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
