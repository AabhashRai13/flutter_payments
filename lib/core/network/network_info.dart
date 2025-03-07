
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  NetworkInfo();
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> isConnected() async {
    return InternetConnection().hasInternetAccess;
  }
}
