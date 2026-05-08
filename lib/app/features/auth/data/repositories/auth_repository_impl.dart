import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_message_response.dart';
import '../models/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthMessageResponse> register({
    required String name,
    required String email,
    required String referralCode,
    required String password,
    required String confirmPassword,
  }) {
    return _remoteDataSource.register(
      name: name,
      email: email,
      referralCode: referralCode,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<AuthMessageResponse> resendRegisterOtp({required String email}) {
    return _remoteDataSource.resendRegisterOtp(email: email);
  }

  @override
  Future<AuthMessageResponse> requestForgotPassword({required String email}) {
    return _remoteDataSource.requestForgotPassword(email: email);
  }

  @override
  Future<AuthMessageResponse> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) {
    return _remoteDataSource.verifyForgotPasswordOtp(email: email, otp: otp);
  }

  @override
  Future<AuthMessageResponse> resetForgotPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _remoteDataSource.resetForgotPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<AuthMessageResponse> logout() {
    return _remoteDataSource.logout();
  }

  @override
  Future<AuthMessageResponse> verifyRegisterOtp({
    required String email,
    required String otp,
  }) {
    return _remoteDataSource.verifyRegisterOtp(email: email, otp: otp);
  }
}
