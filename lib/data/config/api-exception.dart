/// Custom Exceptions class representing the exceptions in the app
class AppException implements Exception {
  /// represent the exception message
  final _message;
  /// represent the prefix that will appear before message
  final _prefix;

  AppException([this._message, this._prefix]);

  /// return the exception prefix and message as string
  String toString() {
    return "$_prefix$_message";
  }

}

/// Class represent all the fetching data exception
class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

/// Class represent all the Bad Requests exception
class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

/// Class represent all the authorizations exception
class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}

/// Class represent all the Invalid input exception
class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}

/// Class represent all the Empty data exception
class NoDataException extends AppException {
  NoDataException([String message = ""]) : super(message, "No Data:");
}