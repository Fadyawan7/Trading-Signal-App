class UserRolesResponse {
  final bool status;
  final String message;
  final UserRolesData? data;

  UserRolesResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory UserRolesResponse.fromJson(Map<String, dynamic> json) {
    return UserRolesResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? UserRolesData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserRolesData {
  final int userId;
  final List<UserRole> roles;
  final String traderStatus;
  final bool isSubscription;

  UserRolesData({
    required this.userId,
    required this.roles,
    required this.traderStatus,
    required this.isSubscription,
  });

  factory UserRolesData.fromJson(Map<String, dynamic> json) {
    final rolesJson = json['roles'] as List? ?? [];
    final List<UserRole> rolesList = rolesJson
        .map((e) => UserRole.fromJson(e as Map<String, dynamic>))
        .toList();

    return UserRolesData(
      userId: json['user_id'] as int? ?? 0,
      roles: rolesList,
      traderStatus: json['trader_status'] as String? ?? 'pending',
      isSubscription: json['is_subscription'] as bool? ?? false,
    );
  }
}

class UserRole {
  final String name;
  final String displayName;

  UserRole({
    required this.name,
    required this.displayName,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      name: json['name'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
    );
  }
}
