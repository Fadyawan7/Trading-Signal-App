class AppConstants {
  static const appName = 'Trading Groups Marketplace';
  static const mobileFrameWidth = 430.0;
}

class AppNetworkConstants {
  static const baseUrl = 'https://apitradenexis.devmode.sbs/';
  static const requestTimeout = Duration(seconds: 30);
}

class ApiEndpoints {
  static const register = 'api/auth/register';
  static const verifyRegisterOtp = 'api/auth/register/verify-otp';
  static const resendRegisterOtp = 'api/auth/register/resend-otp';
  static const login = 'api/auth/login';
  static const forgotPasswordRequest = 'api/auth/forgot-password/request';
  static const forgotPasswordVerifyOtp = 'api/auth/forgot-password/verify-otp';
  static const forgotPasswordReset = 'api/auth/forgot-password/reset';
  static const logout = 'api/logout';
}
