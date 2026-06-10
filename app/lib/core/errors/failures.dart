abstract class Failure {
  final String message;
  final String? errorCode;
  final int? statusCode;
  const Failure(this.message, {this.errorCode, this.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode, String? errorCode})
      : super(message, statusCode: statusCode, errorCode: errorCode);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
