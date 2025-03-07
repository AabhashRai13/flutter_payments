import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_checkout_implementation/core/error/exceptions.dart';
import 'package:flutter_checkout_implementation/core/error/failures.dart';
import 'package:flutter_checkout_implementation/core/network/api_service.dart';
import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:flutter_checkout_implementation/core/utils/resources/typedef.dart';
import 'package:flutter_checkout_implementation/data/model/payment_response_model.dart';
import 'package:flutter_checkout_implementation/domain/entities/cart_details.dart';
import 'package:flutter_checkout_implementation/domain/entities/payment_success_response.dart';
import 'package:flutter_checkout_implementation/domain/entities/token.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentToken> generateToken(CardDetails cardDetails);
  Future<bool> validateCard(String cardNumber);
  Future<String> handle3DSChallenge(
    String authUrl,
    String successUrl,
    String failUrl,
  );
  ResultFuture<PaymentSuccessResponse> processPayment(PaymentParams paymentParams);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl(
      {required this.checkoutPayment, required this.apiService,});

  final FlutterCheckoutPayment checkoutPayment;
  final ApiService apiService;

  @override
  Future<PaymentToken> generateToken(CardDetails cardDetails) async {
    try {
      final response = await FlutterCheckoutPayment.generateToken(
        number: cardDetails.cardNumber,
        name: cardDetails.cardHolderName,
        expiryMonth: cardDetails.expiryMonth,
        expiryYear: cardDetails.expiryYear,
        cvv: cardDetails.cvv,
      );

      if (response?.token == null) {
        throw const ServerException(
          message: 'Token generation failed',
          statusCode: 500,
        );
      }

      return PaymentToken(tokenValue: response!.token!);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<bool> validateCard(String cardNumber) async {
    try {
      final isValid =
          await FlutterCheckoutPayment.isCardValid(number: cardNumber);
      return isValid ?? false;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> handle3DSChallenge(
    String authUrl,
    String successUrl,
    String failUrl,
  ) async {
    try {
      final response = await FlutterCheckoutPayment.handle3DS(
        authUrl: authUrl,
        successUrl: successUrl,
        failUrl: failUrl,
      );
      return response ?? '';
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  ResultFuture<PaymentSuccessResponse> processPayment(
    PaymentParams paymentParams,
  ) async {
    try {
      final response = await apiService.processPayment(paymentParams);
      if (response.statusCode == 200) {
        return Right(
          PaymentSuccessResponseModel.fromJson(
            jsonDecode(response.body) as DataMap,
          ),
        );
      } else {
        final responseMap = jsonDecode(response.body) as DataMap;

        return Left(
          PaymentFailure(
            message: responseMap['message'] as String,
            statusCode: response.statusCode,
            failureType: responseMap['type'] as String,
            errorCode: responseMap['code'] as String,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
