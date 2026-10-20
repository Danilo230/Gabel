sealed class AppException implements Exception {
  const AppException(this.message);
  
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Verifique su conexión a internet e intente nuevamente.']);
}

class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode});

  final int? statusCode;

}

class ParsingException extends AppException {
  const ParsingException([super.message = 'Ocurrió un error al procesar la respuesta del servidor.']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'No autorizado. Por favor, inicie sesión nuevamente.']);
}