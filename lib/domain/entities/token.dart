import 'package:equatable/equatable.dart';

class PaymentToken extends Equatable {

  const PaymentToken({required this.tokenValue});
  final String tokenValue;

  @override
  List<Object?> get props => [tokenValue];
}