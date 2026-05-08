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
  final flow = OtpVerificationFlow.register.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map && arguments['email'] != null) {
      email.value = arguments['email'].toString();
    }
    if (arguments is Map && arguments['flow'] != null) {
      flow.value = OtpVerificationFlow.fromValue(arguments['flow'].toString());
    }
  }

  String? validateOtp(String? value) => AppValidators.validateOtp(value);

  bool get canResendOtp => true;
  String get screenTitle => flow.value == OtpVerificationFlow.register
      ? 'Verify Your Email'
      : 'Verify Reset OTP';
  String get screenSubtitle => flow.value == OtpVerificationFlow.register
      ? 'Enter the 6-digit code sent to'
      : 'Enter the password reset code sent to';
  String get actionLabel => flow.value == OtpVerificationFlow.register
      ? 'Verify & Continue'
      : 'Verify & Reset Password';
  String get loadingMessage => flow.value == OtpVerificationFlow.register
      ? 'Verifying OTP...'
      : 'Verifying reset OTP...';

  Future<void> verifyOtp() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    if (email.value.isEmpty) {
      showError(
        flow.value == OtpVerificationFlow.register
            ? 'Email is missing. Please register again.'
            : 'Email is missing. Please restart the forgot password flow.',
      );
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        final response = flow.value == OtpVerificationFlow.register
            ? await _authRepository.verifyRegisterOtp(
                email: email.value,
                otp: otpController.text.trim(),
              )
            : await _authRepository.verifyForgotPasswordOtp(
                email: email.value,
                otp: otpController.text.trim(),
              );

        showSuccess(response.message);
        if (flow.value == OtpVerificationFlow.register) {
          Get.offAllNamed(AppRoutes.login);
          return;
        }
        Get.toNamed(
          AppRoutes.resetPassword,
          arguments: {'email': email.value},
        );
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('OTP verification failed. Please try again.');
      }
    });
  }

  Future<void> resendOtp() async {
    if (email.value.isEmpty) {
      showError(
        flow.value == OtpVerificationFlow.register
            ? 'Email is missing. Please register again.'
            : 'Email is missing. Please restart the forgot password flow.',
      );
      return;
    }
    if (!ensureInternetConnection()) {
      return;
    }

    await runWithLoading(() async {
      try {
        final response = flow.value == OtpVerificationFlow.register
            ? await _authRepository.resendRegisterOtp(email: email.value)
            : await _authRepository.requestForgotPassword(email: email.value);
        otpController.clear();
        showSuccess(response.message);
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Unable to resend OTP. Please try again.');
      }
    });
  }
}

enum OtpVerificationFlow {
  register,
  forgotPassword;

  static OtpVerificationFlow fromValue(String value) {
    return value == forgotPassword.name
        ? forgotPassword
        : register;
  }
}
