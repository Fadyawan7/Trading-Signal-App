import '../../data/models/auth_message_response.dart';
import '../../data/models/login_response.dart';

abstract class AuthRepository {
  Future<AuthMessageResponse> register({
    required String name,
    required String email,
    required String referralCode,
    required String password,
    required String confirmPassword,
    required String deviceName,
    required String deviceType,
    required String deviceId,
  });

  Future<AuthMessageResponse> verifyRegisterOtp({
    required String email,
    required String otp,
  });

  Future<AuthMessageResponse> resendRegisterOtp({required String email});

  Future<AuthMessageResponse> requestForgotPassword({required String email});

  Future<AuthMessageResponse> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<AuthMessageResponse> resetForgotPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<LoginResponse> login({
    required String email,
    required String password,
    required String deviceName,
    required String deviceType,
    required String deviceId,
  });

  Future<AuthMessageResponse> logout();
}
