part of 'payment_bloc.dart';

 class PaymentState extends Equatable {
  const PaymentState();
  
  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentLoaded extends PaymentState {
  const PaymentLoaded({required this.token});
  final PaymentToken token;
}

final class PaymentError extends PaymentState {
  const PaymentError({required this.message});
  final String message;
}
