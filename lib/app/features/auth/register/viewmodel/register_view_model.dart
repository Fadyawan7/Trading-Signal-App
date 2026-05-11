import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_view_model.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/services/device_service.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/repositories/auth_repository.dart';

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel({
    required AuthRepository authRepository,
    required DeviceService deviceService,
  }) : _authRepository = authRepository,
       _deviceService = deviceService;

  final AuthRepository _authRepository;
  final DeviceService _deviceService;

  final title = 'Create Account';
  final subtitle = 'Join premium groups and verified traders.';
  final cta = 'Register';

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final referralCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validateName(String? value) => AppValidators.validateName(value);
  String? validateEmail(String? value) => AppValidators.validateEmail(value);
  String? validatePassword(String? value) =>
      AppValidators.validatePassword(value);
  String? validateConfirmPassword(String? value) {
    return AppValidators.validateConfirmPassword(
      value,
      password: passwordController.text,
    );
  }

  Future<void> register() async {
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
        final response = await _authRepository.register(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          referralCode: referralCodeController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          deviceName: _deviceService.deviceName,
          deviceType: _deviceService.deviceType,
          deviceId: _deviceService.deviceId,
        );

        showSuccess(response.message);
        Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {'email': emailController.text.trim()},
        );
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Registration failed. Please try again.');
      }
    });
  }
}
