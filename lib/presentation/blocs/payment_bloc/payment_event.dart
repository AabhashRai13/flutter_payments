part of 'payment_bloc.dart';
 class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class GenerateTokenEvent extends PaymentEvent {
  const GenerateTokenEvent( {required this.cardDetails});
  final CardDetails cardDetails;

  @override
  List<Object> get props => [cardDetails];
}