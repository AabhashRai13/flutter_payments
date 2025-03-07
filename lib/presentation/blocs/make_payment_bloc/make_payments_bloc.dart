import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_checkout_implementation/core/error/failures.dart';
import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:flutter_checkout_implementation/domain/entities/payment_success_response.dart';
import 'package:flutter_checkout_implementation/domain/usecase/process_payment_usecase.dart';

part 'make_payments_event.dart';
part 'make_payments_state.dart';

class MakePaymentsBloc extends Bloc<MakePaymentsEvent, MakePaymentsState> {
  MakePaymentsBloc({required this.processPaymentUsecase})
      : super(MakePaymentsInitial()) {
    on<MakePayment>(onMakePayment);
  }
  final ProcessPaymentUsecase processPaymentUsecase;

  Future<void> onMakePayment(
      MakePayment event, Emitter<MakePaymentsState> emit,) async {
    emit(MakePaymentLoading());
    final result = await processPaymentUsecase(event.paymentParams);
    result.fold((l) {
      if (l is PaymentFailure) {
        emit(MakePaymentError(message: l.message ?? ''));
      } else if (l is ServerFailure) {
        emit(const MakePaymentError(message: 'Server Failure'));
      } else {
        emit(const MakePaymentError(message: 'Something went wrong'));
      }
    }, (paymentSuccessResponse) {
      emit(MakePaymentLoaded(paymentSuccessResponse: paymentSuccessResponse));
    });
  }
}
