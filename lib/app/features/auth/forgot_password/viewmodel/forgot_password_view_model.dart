import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_view_model.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/repositories/auth_repository.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  ForgotPasswordViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final title = 'Forgot Password';
  final subtitle = 'Reset your password and continue trading.';
  final cta = 'Send OTP';

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String? validateEmail(String? value) => AppValidators.validateEmail(value);

  Future<void> requestOtp() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        final email = emailController.text.trim();
        final response = await _authRepository.requestForgotPassword(
          email: email,
        );

        showSuccess(response.message);
        Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {'email': email, 'flow': 'forgotPassword'},
        );
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Unable to send OTP. Please try again.');
      }
    });
  }
}
