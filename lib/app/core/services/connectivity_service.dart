import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Future<ConnectivityService> init() async {
    final result = await _connectivity.checkConnectivity();
    _updateState(result);
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
    return this;
  }

  void _updateState(List<ConnectivityResult> results) {
    isConnected.value = !results.contains(ConnectivityResult.none);
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
