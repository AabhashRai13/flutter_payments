import 'package:flutter_checkout_implementation/domain/entities/payment_success_response.dart';

class PaymentSuccessResponseModel extends PaymentSuccessResponse {

  const PaymentSuccessResponseModel({
    required super.success,
    required PaymentDataModel super.data,
  });
  factory PaymentSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentSuccessResponseModel(
      success: json['success'] as bool,
      data: PaymentDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': (data as PaymentDataModel).toJson(),
    };
  }
}

class PaymentDataModel extends PaymentData {
  const PaymentDataModel({
    required super.paymentId,
    required super.status,
    required super.amount,
    required super.currency,
    required super.reference,
    required super.processingTime,
    required super.paymentMethod,
    required RiskInfoModel super.risk,
    required CustomerInfoModel super.customerInfo,
  });

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentDataModel(
      paymentId: json['paymentId'] as String,
      status: json['status'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
      reference: json['reference'] as String,
      processingTime: json['processingTime'] as String,
      paymentMethod: json['paymentMethod'] as String,
      risk: RiskInfoModel.fromJson(json['risk'] as Map<String, dynamic>),
      customerInfo: CustomerInfoModel.fromJson(
          json['customerInfo'] as Map<String, dynamic>,),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'status': status,
      'amount': amount,
      'currency': currency,
      'reference': reference,
      'processingTime': processingTime,
      'paymentMethod': paymentMethod,
      'risk': (risk as RiskInfoModel).toJson(),
      'customerInfo': (customerInfo as CustomerInfoModel).toJson(),
    };
  }
}

class RiskInfoModel extends RiskInfo {
  const RiskInfoModel({
    required super.flagged,
    required super.score,
  });

  factory RiskInfoModel.fromJson(Map<String, dynamic> json) {
    return RiskInfoModel(
      flagged: json['flagged'] as bool,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flagged': flagged,
      'score': score,
    };
  }
}

class CustomerInfoModel extends CustomerInfo {
  const CustomerInfoModel({
    required super.id,
    required super.email,
  });

  factory CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return CustomerInfoModel(
      id: json['id'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }
}
