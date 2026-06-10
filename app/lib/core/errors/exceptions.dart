class ServerException implements Exception {
  final int statusCode;
  final String message;
  final String? errorCode;

  ServerException({
    required this.message,
    required this.statusCode,
    this.errorCode,
  });

  @override
  String toString() => 'ServerException: $message (Status: $statusCode, Code: $errorCode)';
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}
