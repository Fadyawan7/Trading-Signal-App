import '../../data/models/auth_message_response.dart';
import '../../data/models/login_response.dart';

abstract class AuthRepository {
  Future<AuthMessageResponse> register({
    required String name,
    required String email,
    required String referralCode,
    required String password,
    required String confirmPassword,
  });

  Future<AuthMessageResponse> verifyRegisterOtp({
    required String email,
    required String otp,
  });

  Future<AuthMessageResponse> resendRegisterOtp({required String email});

  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<AuthMessageResponse> logout();
}
