import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectionUtils {
  Future<bool> hasConnection() async =>
      isConnectivityResultPositive(await (Connectivity().checkConnectivity()));

  bool isConnectivityResultPositive(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }

  Stream getConnectionStream() => Connectivity().onConnectivityChanged;
}
