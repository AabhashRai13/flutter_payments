import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message, statusCode];
}

class CredentialsException implements Exception {}

class ApiException extends Equatable implements Exception {
  const ApiException({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message, statusCode];
}

class PaymentException extends Equatable implements Exception {
  const PaymentException({required this.message, required this.statusCode, this.errorCode, this.errorType});
  final String message;
  final int statusCode;
  final String? errorCode;
  final String? errorType;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message, statusCode, errorCode, errorType];
}
