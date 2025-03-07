import 'package:flutter_checkout_implementation/domain/entities/token.dart';

class PaymentTokenModel extends PaymentToken {
  const PaymentTokenModel({required super.tokenValue});

  factory PaymentTokenModel.fromJson(Map<String, dynamic> json) {
    return PaymentTokenModel(
      tokenValue: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': tokenValue,
    };
  }
}
