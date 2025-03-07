import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:flutter_checkout_implementation/domain/entities/cart_details.dart';
import 'package:flutter_checkout_implementation/presentation/blocs/make_payment_bloc/make_payments_bloc.dart';
import 'package:flutter_checkout_implementation/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:flutter_checkout_implementation/presentation/views/payment_sucess_page.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardNameHolder = '';
  String cvv = '';
  bool cvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: BlocConsumer<MakePaymentsBloc, MakePaymentsState>(
        listener: (context, state) {
          if (state is MakePaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is MakePaymentLoaded) {
            log(state.paymentSuccessResponse.data.paymentId);
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const PaymentSuccessPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
              if (state is PaymentLoaded) {
                // Handle successful token generation
                log(state.token.tokenValue);
                context.read<MakePaymentsBloc>().add(
                      MakePayment(
                        paymentParams: PaymentParams(
                          token: state.token.tokenValue,
                          amount: 10000,
                          currency: 'USD',
                          reference: '1234567890',
                          customerInfo: CustomerInfo(
                            email: 'test@test.com',
                            name: 'Test User',
                            addressLine1: '123 Main St',
                            addressLine2: 'Apt 1',
                            city: 'Anytown',
                            state: 'CA',
                            zip: '12345',
                            country: 'USA',
                            countryCode: 'US',
                            phone: '1234567890',
                          ),
                        ),
                      ),
                    );
              }
            },
            builder: (context, state) {
              if (state is PaymentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PaymentError) {
                return Center(child: Text(state.message));
              }
              return _buildPaymentForm();
            },
          );
        },
      ),
    );
  }

  Widget _buildPaymentForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardNameHolder,
            cvvCode: cvv,
            showBackView: cvvFocused,
            onCreditCardWidgetChange: (_) {},
          ),
          CreditCardForm(
            formKey: formKey,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardNameHolder,
            cvvCode: cvv,
            onCreditCardModelChange: (CreditCardModel model) {
              setState(() {
                cardNumber = model.cardNumber;
                expiryDate = model.expiryDate;
                cardNameHolder = model.cardHolderName;
                cvv = model.cvvCode;
                cvvFocused = model.isCvvFocused;
              });
            },
          ),
          ElevatedButton(
            onPressed: _generateToken,
            child: const Text('Generate Token'),
          ),
        ],
      ),
    );
  }

  void _generateToken() {
    if (!formKey.currentState!.validate()) return;

    // Check if expiry date has correct format (MM/YY)
    if (expiryDate.length != 5 || !expiryDate.contains('/')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid expiry date format')),
      );
      return;
    }

    final cardDetails = CardDetails(
      cardNumber: cardNumber.replaceAll(' ', ''),
      expiryMonth: expiryDate.split('/')[0],
      expiryYear: expiryDate.split('/')[1],
      cardHolderName: cardNameHolder,
      cvv: cvv,
    );

    context
        .read<PaymentBloc>()
        .add(GenerateTokenEvent(cardDetails: cardDetails));
  }
}
