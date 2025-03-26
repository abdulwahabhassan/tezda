// enum Status { idle, loading, error, success }

sealed class Status {}

class Idle extends Status {}

class Success<T> extends Status {
  final T data;

  Success(this.data);
}

class Loading extends Status {}

class Error extends Status {
  final String message;

  Error(this.message);
}
