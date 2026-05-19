import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/services/session_service.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';

class HomeViewModel extends BaseViewModel {
  final title = 'Home';
  final subtitle = 'Discover high-performance trading communities.';
  final cta = 'Browse Groups';

  Future<void> refreshHome() async {
    try {
      final sessionService = Get.find<SessionService>();
      final profileRepository = Get.find<ProfileRepository>();
      
      final response = await profileRepository.getUserRoles();
      if (response.status && response.data != null) {
        final data = response.data!;
        final roles = data.roles.map((e) => e.name).toList();
        await sessionService.saveRolesData(
          roles: roles,
          traderStatus: data.traderStatus,
          isSubscription: data.isSubscription,
        );
      }
    } catch (e) {
      debugPrint('Error refreshing home roles: $e');
    }
  }
}

