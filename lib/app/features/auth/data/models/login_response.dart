import 'auth_user.dart';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.message,
    required this.user,
  });

  final bool status;
  final String message;
  final AuthUser user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      user: AuthUser.fromJson((json['data'] as Map<String, dynamic>?) ?? {}),
    );
  }
}
