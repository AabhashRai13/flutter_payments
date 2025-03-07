import 'package:dartz/dartz.dart';
import 'package:flutter_checkout_implementation/core/error/failures.dart';
import 'package:flutter_checkout_implementation/core/usecases/usecase.dart';
import 'package:flutter_checkout_implementation/domain/entities/cart_details.dart';
import 'package:flutter_checkout_implementation/domain/entities/token.dart';
import 'package:flutter_checkout_implementation/domain/repository/payment_repository.dart';


class TokenizeCard implements UseCase<PaymentToken, CardDetails> {

  TokenizeCard(this.repository);
  final PaymentRepository repository;

  @override
  Future<Either<Failure, PaymentToken>> call(CardDetails params) {
    return repository.generateToken(params);
  }
}