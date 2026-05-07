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
  static const logout = 'api/logout';
}
