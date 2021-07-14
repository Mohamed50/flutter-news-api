import 'package:flutter/material.dart';
import 'package:news_app/data/config/api-exception.dart';
import 'package:news_app/data/config/api-response.dart';
import 'translatable-text.dart';


class ApiResponseHandler extends StatelessWidget {
  final ApiResponse apiResponse;
  final Widget loading;
  final Widget completed;
  final Widget error;
  final Widget noData;
  final String noDataMessage;
  final Function tryAgain;

  const ApiResponseHandler(
      {Key key,
      this.apiResponse,
      this.loading,
      @required this.completed,
      this.error,
      this.tryAgain,
      this.noData,
      this.noDataMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(apiResponse.status.toString());
    switch (apiResponse.status) {
      case Status.LOADING:
      case Status.INITIAL:
        return loading ?? Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return completed;
      case Status.ERROR:
        if (apiResponse.exception is NoDataException)
          return Center(child: noData ?? TranslatableText(noDataMessage ?? "No Data"));
        else if (tryAgain != null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TranslatableText(apiResponse.message),
              TextButton(
                onPressed: tryAgain,
                child: TranslatableText("Try Again"),
              ),
            ],
          );
        else
          return error ?? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: TranslatableText(apiResponse.message),
          );
        break;
      default:
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),child: TranslatableText(apiResponse.message));
    }
  }
}
