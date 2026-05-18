import '../../../auth/data/models/auth_user.dart';

class ProfileResponse {
  ProfileResponse({
    required this.status,
    required this.message,
    required this.user,
  });

  final bool status;
  final String message;
  final AuthUser user;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      user: AuthUser.fromJson((json['data'] as Map<String, dynamic>?) ?? {}),
    );
  }
}
