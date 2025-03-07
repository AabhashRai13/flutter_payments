
import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:flutter_checkout_implementation/core/usecases/usecase.dart';
import 'package:flutter_checkout_implementation/core/utils/resources/typedef.dart';
import 'package:flutter_checkout_implementation/domain/entities/payment_success_response.dart';
import 'package:flutter_checkout_implementation/domain/repository/payment_repository.dart';

class ProcessPaymentUsecase
    implements UseCase<PaymentSuccessResponse, PaymentParams> {
  ProcessPaymentUsecase(this.repository);
  final PaymentRepository repository;
  @override
  ResultFuture<PaymentSuccessResponse> call(PaymentParams params) {
    return repository.processPayment(params);
  }
}
