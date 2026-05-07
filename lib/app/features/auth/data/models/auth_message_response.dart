class AuthMessageResponse {
  AuthMessageResponse({required this.status, required this.message});

  final bool status;
  final String message;

  factory AuthMessageResponse.fromJson(Map<String, dynamic> json) {
    return AuthMessageResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
    );
  }
}
