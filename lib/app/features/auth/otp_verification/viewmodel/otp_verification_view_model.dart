import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_view_model.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/repositories/auth_repository.dart';

class OtpVerificationViewModel extends BaseViewModel {
  OtpVerificationViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final title = 'OTP Verification';
  final subtitle = 'Enter the secure code sent to your phone.';
  final cta = 'Verify OTP';

  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map && arguments['email'] != null) {
      email.value = arguments['email'].toString();
    }
  }

  String? validateOtp(String? value) => AppValidators.validateOtp(value);

  Future<void> verifyOtp() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    if (email.value.isEmpty) {
      showError('Email is missing. Please register again.');
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        final response = await _authRepository.verifyRegisterOtp(
          email: email.value,
          otp: otpController.text.trim(),
        );

        showSuccess(response.message);
        Get.offAllNamed(AppRoutes.login);
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('OTP verification failed. Please try again.');
      }
    });
  }

  Future<void> resendOtp() async {
    if (email.value.isEmpty) {
      showError('Email is missing. Please register again.');
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        final response = await _authRepository.resendRegisterOtp(
          email: email.value,
        );
        otpController.clear();
        showSuccess(response.message);
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Unable to resend OTP. Please try again.');
      }
    });
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
