import 'package:equatable/equatable.dart';
import 'package:flutter_checkout_implementation/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({this.message, this.statusCode, this.userId, this.failureType, this.errorCode});

  final String? message;
  final int? statusCode;
  final int? userId;
  final String? failureType;
  final String? errorCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  String toString() => message!;
  @override
  List<Object> get props => [
        message!,
        statusCode!,
        userId!,
        failureType!,
        errorCode!,
      ];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({
    super.message,
    super.statusCode,
  });

  ServerFailure.fromException(ServerException exception)
      : super(
          message: exception.toString(),
          statusCode: 500,
        );
}

// General failures
class CredentialsFailure extends Failure {
  const CredentialsFailure({
    super.message,
    super.statusCode,
  });

  CredentialsFailure.fromException(CredentialsException exception)
      : super(
          message: exception.toString(),
          statusCode: 401,
        );
}

// General failures
class PackageFailure extends Failure {}

// special errors
class DeleteUserFailure extends Failure {}

class NoUserFailure extends Failure {}

class EmailNotFound extends Failure {}

class UserWasDeletedFailure extends Failure {}

class UserIsNotVerifiedFailure extends Failure {
  const UserIsNotVerifiedFailure(
      {super.message, super.statusCode, super.userId,});
}

class CodeExpired extends Failure {
  const CodeExpired({super.message, super.statusCode, super.userId});
}

//Payment errors
class PaymentFailure extends Failure {
  const PaymentFailure({required super.message, required super.statusCode, required super.failureType, required super.errorCode});

  PaymentFailure.fromException(PaymentException exception)
      : super(message: exception.message, statusCode: exception.statusCode, failureType: exception.errorType, errorCode: exception.errorCode);
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(ApiException exception)
      : super(message: exception.message, statusCode: exception.statusCode);
}
