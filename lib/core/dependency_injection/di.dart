import 'package:flutter_checkout_implementation/core/network/api_service.dart';
import 'package:flutter_checkout_implementation/core/network/network_info.dart';
import 'package:flutter_checkout_implementation/data/datasource/remote/payment_remote_datasource.dart';
import 'package:flutter_checkout_implementation/data/repository_implementation.dart';
import 'package:flutter_checkout_implementation/domain/repository/payment_repository.dart';
import 'package:flutter_checkout_implementation/domain/usecase/process_payment_usecase.dart';
import 'package:flutter_checkout_implementation/domain/usecase/tokenize_card_usecase.dart';
import 'package:flutter_checkout_implementation/presentation/blocs/make_payment_bloc/make_payments_bloc.dart';
import 'package:flutter_checkout_implementation/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

part 'di.main.dart';
