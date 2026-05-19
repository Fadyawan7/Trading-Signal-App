import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';

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
      try {
        final profileRepository = Get.find<ProfileRepository>();
        final response = await profileRepository.getUserRoles();
        if (response.status && response.data != null) {
          final data = response.data!;
          final roles = data.roles.map((e) => e.name).toList();
          await _sessionService.saveRolesData(
            roles: roles,
            traderStatus: data.traderStatus,
            isSubscription: data.isSubscription,
          );
        }
      } catch (e) {
        debugPrint('Error fetching user roles on splash: $e');
      }

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

