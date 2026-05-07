import 'package:get/get.dart';

import '../../../../core/base/base_view_model.dart';
import '../../../../core/services/session_service.dart';
import '../../../../routes/app_routes.dart';

class RoleSelectionViewModel extends BaseViewModel {
  RoleSelectionViewModel({required SessionService sessionService})
    : _sessionService = sessionService;

  final SessionService _sessionService;

  final title = 'Select Role';
  final subtitle = 'Choose your mode to personalize the experience.';
  final cta = 'Continue';

  Future<void> continueAsUser() async {
    await _sessionService.completeRoleSelection();
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> continueAsTrader() async {
    await _sessionService.completeRoleSelection();
    Get.toNamed(AppRoutes.applyTrader);
  }
}
