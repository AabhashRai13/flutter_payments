import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_checkout_implementation/domain/entities/cart_details.dart';
import 'package:flutter_checkout_implementation/domain/entities/token.dart';
import 'package:flutter_checkout_implementation/domain/usecase/tokenize_card_usecase.dart';
part 'payment_event.dart';
part 'payment_state.dart';


class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {

  PaymentBloc({required this.tokenizeCard}) : super(PaymentInitial()) {
    on<GenerateTokenEvent>(_onGenerateToken);
  }
  final TokenizeCard tokenizeCard;

  Future<void> _onGenerateToken(
    GenerateTokenEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    
    final result = await tokenizeCard(event.cardDetails);
    
    result.fold(
      (failure) => emit(PaymentError(message: failure.toString())),
      (token) => emit(PaymentLoaded(token: token)),
    );
  }
}