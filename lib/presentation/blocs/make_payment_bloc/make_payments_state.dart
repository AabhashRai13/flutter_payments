part of 'make_payments_bloc.dart';

sealed class MakePaymentsState extends Equatable {
  const MakePaymentsState();
  
  @override
  List<Object> get props => [];
}

final class MakePaymentsInitial extends MakePaymentsState {}

final class MakePaymentLoading extends MakePaymentsState {}

final class MakePaymentLoaded extends MakePaymentsState {
  const MakePaymentLoaded({required this.paymentSuccessResponse});
  final PaymentSuccessResponse paymentSuccessResponse;
}

final class MakePaymentError extends MakePaymentsState {
  const MakePaymentError({required this.message});
  final String message;
}

