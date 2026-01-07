sealed class Results<T> {}

class Success<T> extends Results<T>{
  final T? data;
  String? message;

  Success({required this.data, this.message});
}
class Failure<T> extends Results<T>{
  final Exception exception;
  final String errorMessage;

  Failure(this.exception,this.errorMessage);
}