import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnectionUtils {
  Future<bool> hasConnection() async =>
      InternetConnectionChecker().hasConnection;

  Stream<InternetConnectionStatus> get connectionStream =>
      InternetConnectionChecker().onStatusChange;
}
