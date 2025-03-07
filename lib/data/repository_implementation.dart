import 'package:dartz/dartz.dart';
import 'package:flutter_checkout_implementation/core/error/exceptions.dart';
import 'package:flutter_checkout_implementation/core/error/failures.dart';
import 'package:flutter_checkout_implementation/core/network/network_info.dart';
import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:flutter_checkout_implementation/core/utils/resources/typedef.dart';
import 'package:flutter_checkout_implementation/data/datasource/remote/payment_remote_datasource.dart';
import 'package:flutter_checkout_implementation/domain/entities/cart_details.dart';
import 'package:flutter_checkout_implementation/domain/entities/payment_success_response.dart';
import 'package:flutter_checkout_implementation/domain/entities/token.dart';
import 'package:flutter_checkout_implementation/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PaymentToken>> generateToken(
    CardDetails cardDetails,
  ) async {
    try {
      final token = await remoteDataSource.generateToken(cardDetails);
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> validateCard(String cardNumber) async {
    try {
      final isValid = await remoteDataSource.validateCard(cardNumber);
      return Right(isValid);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> handle3DSChallenge({
    required String authUrl,
    required String successUrl,
    required String failUrl,
  }) async {
    try {
      final result = await remoteDataSource.handle3DSChallenge(
        authUrl,
        successUrl,
        failUrl,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<PaymentSuccessResponse> processPayment(
    PaymentParams paymentParams,
  ) async {
    final connection = await networkInfo.isConnected();
    if (connection) {
      try {
        final result = await remoteDataSource.processPayment(paymentParams);
        return result;
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
