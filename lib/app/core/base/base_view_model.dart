import 'package:get/get.dart';

import '../services/app_feedback_service.dart';
import '../services/connectivity_service.dart';

class BaseViewModel extends GetxController {
  BaseViewModel({
    ConnectivityService? connectivityService,
    AppFeedbackService? feedbackService,
  }) : _connectivityService =
           connectivityService ?? Get.find<ConnectivityService>(),
       _feedbackService = feedbackService ?? Get.find<AppFeedbackService>();

  final ConnectivityService _connectivityService;
  final AppFeedbackService _feedbackService;

  final isLoading = false.obs;

  RxBool get isConnected => _connectivityService.isConnected;

  Future<T?> runWithLoading<T>(Future<T> Function() action) async {
    if (isLoading.value) {
      return null;
    }

    isLoading.value = true;
    try {
      return await action();
    } finally {
      isLoading.value = false;
    }
  }

  bool ensureInternetConnection() {
    if (_connectivityService.isConnected.value) {
      return true;
    }

    showError(
      'No internet connection. Please check your network and try again.',
    );
    return false;
  }

  void showSuccess(String message, {String title = 'Success'}) {
    _feedbackService.showSuccess(title: title, message: message);
  }

  void showError(String message, {String title = 'Error'}) {
    _feedbackService.showError(title: title, message: message);
  }

  void showInfo(String message, {String title = 'Notice'}) {
    _feedbackService.showInfo(title: title, message: message);
  }
}
