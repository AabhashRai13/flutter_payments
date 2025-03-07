import 'package:dartz/dartz.dart';
import 'package:flutter_checkout_implementation/core/error/failures.dart';
import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:flutter_checkout_implementation/core/utils/resources/typedef.dart';
import 'package:flutter_checkout_implementation/domain/entities/cart_details.dart';
import 'package:flutter_checkout_implementation/domain/entities/payment_success_response.dart';
import 'package:flutter_checkout_implementation/domain/entities/token.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentToken>> generateToken(CardDetails cardDetails);
  Future<Either<Failure, bool>> validateCard(String cardNumber);
  Future<Either<Failure, String>> handle3DSChallenge({
    required String authUrl,
    required String successUrl,
    required String failUrl,
  });
ResultFuture<PaymentSuccessResponse> processPayment(PaymentParams paymentParams);
}