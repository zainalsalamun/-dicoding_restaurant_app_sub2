

enum Status{loading, hasData, error}

class Result<T>{
  final Status status;
  final String? message;
  final T? data;

  Result({
    required this.status,
    required this.message,
    required this.data
  });
}