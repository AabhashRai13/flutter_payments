import 'package:equatable/equatable.dart';

class PaymentUnsuccessfulResponse extends Equatable {
  const PaymentUnsuccessfulResponse({
    required this.success,
    required this.error,
  });
  final bool success;
  final PaymentError error;

  @override
  List<Object?> get props => [success, error];
}

class PaymentError extends Equatable {
  const PaymentError({
    required this.status,
    required this.message,
    required this.code,
    required this.details,
  });

  final String status;
  final String message;
  final String code;
  final PaymentErrorDetails details;

  @override
  List<Object?> get props => [status, message, code, details];
}

class PaymentErrorDetails extends Equatable {
  const PaymentErrorDetails({
    required this.paymentId,
    required this.amount,
    required this.currency,
  });
  final String paymentId;
  final int amount;
  final String currency;

  @override
  List<Object?> get props => [paymentId, amount, currency];
}
