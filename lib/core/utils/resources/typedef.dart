import 'package:dartz/dartz.dart';
import 'package:flutter_checkout_implementation/core/error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure,T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;
