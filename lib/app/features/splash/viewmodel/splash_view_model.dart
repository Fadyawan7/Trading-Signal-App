import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel({required SessionService sessionService})
    : _sessionService = sessionService;

  final SessionService _sessionService;

  @override
  void onReady() {
    super.onReady();
    _routeNext();
  }

  Future<void> _routeNext() async {
    await Future<void>.delayed(const Duration(seconds: 3));

    if (_sessionService.isLoggedIn) {
      Get.offAllNamed(
        _sessionService.hasCompletedRoleSelection
            ? AppRoutes.home
            : AppRoutes.roleSelection,
      );
      return;
    }

    Get.offAllNamed(AppRoutes.login);
  }
}
