part of 'make_payments_bloc.dart';

class MakePaymentsEvent extends Equatable {
  const MakePaymentsEvent();

  @override
  List<Object> get props => [];
}

class MakePayment extends MakePaymentsEvent {
  const MakePayment({required this.paymentParams});
  final PaymentParams paymentParams;

  @override
  List<Object> get props => [paymentParams];
}
