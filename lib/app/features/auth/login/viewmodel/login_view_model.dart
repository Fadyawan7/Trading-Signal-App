import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_view_model.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/services/device_service.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../../user_profile/domain/repositories/profile_repository.dart';
import '../../domain/repositories/auth_repository.dart';


class LoginViewModel extends BaseViewModel {
  LoginViewModel({
    required AuthRepository authRepository,
    required SessionService sessionService,
    required DeviceService deviceService,
  }) : _authRepository = authRepository,
       _sessionService = sessionService,
       _deviceService = deviceService;

  final AuthRepository _authRepository;
  final SessionService _sessionService;
  final DeviceService _deviceService;

  final title = 'Welcome Back';
  final subtitle = 'Sign in to continue your trading journey.';
  final cta = 'Login';

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) => AppValidators.validateEmail(value);
  String? validatePassword(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  Future<void> login() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        await _deviceService.refreshDeviceInfo(forceRefresh: true);
        final response = await _authRepository.login(
          email: emailController.text.trim(),
          password: passwordController.text,
          deviceName: _deviceService.deviceName,
          deviceType: _deviceService.deviceType,
          deviceId: _deviceService.deviceId,
        );

        await _sessionService.saveUser(response.user);

        try {
          final profileRepo = Get.find<ProfileRepository>();
          final rolesResponse = await profileRepo.getUserRoles();
          if (rolesResponse.status && rolesResponse.data != null) {
            final data = rolesResponse.data!;
            final roles = data.roles.map((e) => e.name).toList();
            await _sessionService.saveRolesData(
              roles: roles,
              traderStatus: data.traderStatus,
              isSubscription: data.isSubscription,
            );
          }
        } catch (e) {
          debugPrint('Error fetching user roles on login: $e');
        }

        showSuccess(response.message);
        Get.offAllNamed(AppRoutes.roleSelection);
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Login failed. Please try again.');
      }
    });
  }

}
