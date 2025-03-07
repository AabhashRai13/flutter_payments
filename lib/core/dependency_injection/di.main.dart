part of 'di.dart';

final sl = GetIt.instance;

void initAppModule() {
  /// api service
  _initNetworkCode();
  _initPaymentCode();
}

Future<void> _initNetworkCode() async {
  sl
    //// network
    ..registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new)
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton<ApiService>(ApiService.new);
}

Future<void> _initPaymentCode() async {
  sl
    ..registerLazySingleton<FlutterCheckoutPayment>(
      FlutterCheckoutPayment.new,
    )
    ..registerLazySingleton<PaymentRemoteDataSource>(
      () =>
          PaymentRemoteDataSourceImpl(checkoutPayment: sl(), apiService: sl()),
    )
    ..registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
    )
    ..registerLazySingleton<TokenizeCard>(() => TokenizeCard(sl()))
    ..registerLazySingleton<PaymentBloc>(() => PaymentBloc(tokenizeCard: sl()))
    ..registerLazySingleton<ProcessPaymentUsecase>(
      () => ProcessPaymentUsecase(sl()),
    )
    ..registerLazySingleton<MakePaymentsBloc>(
      () => MakePaymentsBloc(processPaymentUsecase: sl()),
    );
}
