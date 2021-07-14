/// Class represent the states of API Response
/// used to wrap api response
/// initial, loading, complete, error
class ApiResponse<T> {
  /// Contains the response status
  Status status;
  /// contains the response data
  T data;
  /// contains the api response message
  String message;
  /// contains the last page called number used in pagination
  int page;
  /// contains response exception if some exception occurred
  Exception exception;
  /// indicator to know if you need to fetch more pages or not
  bool hasMorePage = false;

  /// Named constructor to create object with initial state
  ApiResponse.initial(this.message, {this.page : 1, this.hasMorePage : false}) : status = Status.INITIAL;

  /// Named constructor to create object with loading state
  ApiResponse.loading(this.message, {this.page : 1, this.hasMorePage : false}) : status = Status.LOADING;

  /// Named constructor to create object with completed state
  ApiResponse.completed(this.data, {this.page : 1, this.hasMorePage : false}) : status = Status.COMPLETED;

  /// Named constructor to create object with error state
  ApiResponse.error(this.message, {this.page : 1, this.hasMorePage : false, this.exception}) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

}


/// Enum for API Response States
enum Status { INITIAL, LOADING, COMPLETED, ERROR }