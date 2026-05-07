import '../../../../core/network/api_client.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/values/app_constants.dart';
import '../models/auth_message_response.dart';
import '../models/login_response.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required ApiClient apiClient,
    required SessionService sessionService,
  }) : _apiClient = apiClient,
       _sessionService = sessionService;

  final ApiClient _apiClient;
  final SessionService _sessionService;

  Future<AuthMessageResponse> register({
    required String name,
    required String email,
    required String referralCode,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.register,
      body: {
        'name': name,
        'email': email,
        'referral_code': referralCode,
        'password': password,
        'confirm_password': confirmPassword,
      },
    );

    return AuthMessageResponse.fromJson(response);
  }

  Future<AuthMessageResponse> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.verifyRegisterOtp,
      body: {'email': email, 'otp': otp},
    );

    return AuthMessageResponse.fromJson(response);
  }

  Future<AuthMessageResponse> resendRegisterOtp({required String email}) async {
    final response = await _apiClient.post(
      ApiEndpoints.resendRegisterOtp,
      body: {'email': email},
    );

    return AuthMessageResponse.fromJson(response);
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      body: {'email': email, 'password': password},
    );

    return LoginResponse.fromJson(response);
  }

  Future<AuthMessageResponse> logout() async {
    final response = await _apiClient.post(
      ApiEndpoints.logout,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return AuthMessageResponse.fromJson(response);
  }
}
