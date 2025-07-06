class BadRequestException implements Exception {
  final String message;
  BadRequestException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({required this.message});
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException({required this.message});
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class UnknownException implements Exception {
  final String message;
  UnknownException({required this.message});
}

class CachedExcaption implements Exception {
  final String message;

  CachedExcaption({required this.message});
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException({required this.message});
}

class SocketException implements Exception {
  final String message;

  SocketException({required this.message});

}