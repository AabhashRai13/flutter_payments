import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_checkout_implementation/core/dependency_injection/di.dart';
import 'package:flutter_checkout_implementation/keys.dart';
import 'package:flutter_checkout_implementation/presentation/blocs/make_payment_bloc/make_payments_bloc.dart';
import 'package:flutter_checkout_implementation/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:flutter_checkout_implementation/presentation/views/payment_page.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  await FlutterCheckoutPayment.init(key: Keys.testKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<PaymentBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<MakePaymentsBloc>(),
          ),
        ],
        child: const PaymentPage(),
      ),
    );
  }
}
