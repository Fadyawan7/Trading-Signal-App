import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';
import '../../auth/domain/repositories/auth_repository.dart';
import '../domain/repositories/profile_repository.dart';

class UserProfileViewModel extends BaseViewModel {
  final loadingMessage = 'Loading...'.obs;

  UserProfileViewModel({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
    required SessionService sessionService,
  }) : _authRepository = authRepository,
       _profileRepository = profileRepository,
       _sessionService = sessionService;

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final SessionService _sessionService;

  final title = 'My Profile';
  final subtitle = 'Track joined groups, ROI, and account details.';
  final cta = 'Edit Profile';

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile({bool showLoading = true}) async {
    if (showLoading) {
      loadingMessage.value = 'Loading...';
      await runWithLoading(_fetchProfile);
    } else {
      await _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    try {
      if (ensureInternetConnection()) {
        final response = await _profileRepository.getProfile();
        await _sessionService.updateUser(response.user);
      }
    } on ApiException catch (error) {
      showError(error.message);
    } catch (_) {
      showError('Failed to fetch profile.');
    }
  }

  Future<void> logout() async {
    if (isLoading.value) {
      return;
    }

    loadingMessage.value = 'Signing you out...';
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
