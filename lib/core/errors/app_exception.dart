sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// No connection, DNS failure, timeout, etc.
class NetworkException extends AppException {
  const NetworkException([super.message = 'Verifica tu conexion a internet.']);
}

/// The server answered with a non-2xx status code.
class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode});

  final int? statusCode;
}

/// The response body could not be parsed into our models.
class ParsingException extends AppException {
  const ParsingException([super.message = 'Formato de respuesta inesperado.']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Credenciales inválidas.']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'No se encontró el recurso solicitado.']);
}