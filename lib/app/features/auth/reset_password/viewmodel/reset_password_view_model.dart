import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_view_model.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/repositories/auth_repository.dart';

class ResetPasswordViewModel extends BaseViewModel {
  ResetPasswordViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map && arguments['email'] != null) {
      email.value = arguments['email'].toString();
    }
  }

  String? validatePassword(String? value) =>
      AppValidators.validatePassword(value);

  String? validateConfirmPassword(String? value) {
    return AppValidators.validateConfirmPassword(
      value,
      password: passwordController.text,
    );
  }

  Future<void> resetPassword() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    if (email.value.isEmpty) {
      showError('Email is missing. Please restart the forgot password flow.');
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        final response = await _authRepository.resetForgotPassword(
          email: email.value,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );

        showSuccess(response.message);
        Get.offAllNamed(AppRoutes.login);
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Password reset failed. Please try again.');
      }
    });
  }
}
