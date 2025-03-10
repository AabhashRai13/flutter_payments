import 'package:flutter_checkout_implementation/domain/entities/payment_unsuccessful.dart';

class PaymentUnsuccessfulResponseModel extends PaymentUnsuccessfulResponse {
  const PaymentUnsuccessfulResponseModel({
    required super.success,
    required PaymentErrorModel super.error,
  });

  factory PaymentUnsuccessfulResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentUnsuccessfulResponseModel(
      success: json['success'] as bool,
      error: PaymentErrorModel.fromJson(json['error'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'error': (error as PaymentErrorModel).toJson(),
      };
}

class PaymentErrorModel extends PaymentError {
  const PaymentErrorModel({
    required super.status,
    required super.message,
    required super.code,
    required PaymentErrorDetailsModel super.details,
  });

  factory PaymentErrorModel.fromJson(Map<String, dynamic> json) {
    return PaymentErrorModel(
      status: json['status'] as String,
      message: json['message'] as String,
      code: json['code'] as String,
      details: PaymentErrorDetailsModel.fromJson(
          json['details'] as Map<String, dynamic>,),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'code': code,
        'details': (details as PaymentErrorDetailsModel).toJson(),
      };
}

class PaymentErrorDetailsModel extends PaymentErrorDetails {
  const PaymentErrorDetailsModel({
    required super.paymentId,
    required super.amount,
    required super.currency,
  });

  factory PaymentErrorDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaymentErrorDetailsModel(
      paymentId: json['paymentId'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'paymentId': paymentId,
        'amount': amount,
        'currency': currency,
      };
}
