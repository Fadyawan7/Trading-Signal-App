import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';
import '../../auth/domain/repositories/auth_repository.dart';

class UserProfileViewModel extends BaseViewModel {
  UserProfileViewModel({
    required AuthRepository authRepository,
    required SessionService sessionService,
  }) : _authRepository = authRepository,
       _sessionService = sessionService;

  final AuthRepository _authRepository;
  final SessionService _sessionService;

  final title = 'My Profile';
  final subtitle = 'Track joined groups, ROI, and account details.';
  final cta = 'Edit Profile';

  Future<void> logout() async {
    if (isLoading.value) {
      return;
    }

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection() && _sessionService.authToken != null) {
          final response = await _authRepository.logout();
          await _sessionService.clearSession();
          showSuccess(response.message);
        } else {
          await _sessionService.clearSession();
          showInfo('Session cleared on this device.');
        }
      } on ApiException catch (error) {
        if (error.statusCode == 401) {
          await _sessionService.clearSession();
          showInfo('Session expired. Please sign in again.');
        } else {
          showError(error.message);
          return;
        }
      } catch (_) {
        showError('Logout failed. Please try again.');
        return;
      }

      Get.offAllNamed(AppRoutes.login);
    });
  }
}
