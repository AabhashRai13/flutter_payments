import 'package:equatable/equatable.dart';

class PaymentSuccessResponse extends Equatable {

  const PaymentSuccessResponse({
    required this.success,
    required this.data,
  });
  final bool success;
  final PaymentData data;

  @override
  List<Object?> get props => [success, data];
}

class PaymentData extends Equatable {

  const PaymentData({
    required this.paymentId,
    required this.status,
    required this.amount,
    required this.currency,
    required this.reference,
    required this.processingTime,
    required this.paymentMethod,
    required this.risk,
    required this.customerInfo,
  });
  final String paymentId;
  final String status;
  final int amount;
  final String currency;
  final String reference;
  final String processingTime;
  final String paymentMethod;
  final RiskInfo risk;
  final CustomerInfo customerInfo;

  @override
  List<Object?> get props => [
        paymentId,
        status,
        amount,
        currency,
        reference,
        processingTime,
        paymentMethod,
        risk,
        customerInfo,
      ];
}

class RiskInfo extends Equatable {

  const RiskInfo({
    required this.flagged,
    required this.score,
  });
  final bool flagged;
  final int score;

  @override
  List<Object?> get props => [flagged, score];
}

class CustomerInfo extends Equatable {

  const CustomerInfo({
    required this.id,
    required this.email,
  });
  final String id;
  final String email;

  @override
  List<Object?> get props => [id, email];
}
