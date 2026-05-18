class TraderMessageResponse {
  TraderMessageResponse({required this.status, required this.message});

  final bool status;
  final String message;

  factory TraderMessageResponse.fromJson(Map<String, dynamic> json) {
    return TraderMessageResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
    );
  }
}
