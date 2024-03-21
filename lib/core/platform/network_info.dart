import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
