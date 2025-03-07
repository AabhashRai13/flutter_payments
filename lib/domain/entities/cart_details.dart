import 'package:equatable/equatable.dart';

class CardDetails extends Equatable   {

  const CardDetails({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardHolderName,
    required this.cvv,
  });
  final String cardNumber;
  final String expiryMonth;
  final String expiryYear;
  final String cardHolderName;
  final String cvv;
  
  @override
  List<Object?> get props => [cardNumber, expiryMonth, expiryYear, cardHolderName, cvv];
}