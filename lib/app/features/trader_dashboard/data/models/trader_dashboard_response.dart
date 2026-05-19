class TraderDashboardResponse {
  final bool status;
  final String message;
  final TraderDashboardData? data;

  TraderDashboardResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory TraderDashboardResponse.fromJson(Map<String, dynamic> json) {
    return TraderDashboardResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? TraderDashboardData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class TraderDashboardData {
  final TraderUser user;
  final TraderStats stats;
  final TraderSubscriptionInfo? subscription;
  final List<TraderGroup> groups;

  TraderDashboardData({
    required this.user,
    required this.stats,
    this.subscription,
    required this.groups,
  });

  factory TraderDashboardData.fromJson(Map<String, dynamic> json) {
    var groupsList = <TraderGroup>[];
    if (json['groups'] != null) {
      final list = json['groups'] as List;
      groupsList = list.map((e) => TraderGroup.fromJson(e as Map<String, dynamic>)).toList();
    }
    return TraderDashboardData(
      user: TraderUser.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      stats: TraderStats.fromJson(json['stats'] as Map<String, dynamic>? ?? {}),
      subscription: json['subscription'] != null ? TraderSubscriptionInfo.fromJson(json['subscription'] as Map<String, dynamic>) : null,
      groups: groupsList,
    );
  }
}

class TraderUser {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String? profileImage;
  final dynamic uid;
  final List<String> role;

  TraderUser({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.profileImage,
    this.uid,
    required this.role,
  });

  factory TraderUser.fromJson(Map<String, dynamic> json) {
    final rolesList = <String>[];
    if (json['role'] != null) {
      final list = json['role'] as List;
      rolesList.addAll(list.map((e) => e.toString()));
    }
    return TraderUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      profileImage: json['profile_image'] as String?,
      uid: json['uid'],
      role: rolesList,
    );
  }
}

class TraderStats {
  final int totalMembers;
  final dynamic monthlyRevenue;
  final int totalSignals;
  final String successRate;

  TraderStats({
    required this.totalMembers,
    required this.monthlyRevenue,
    required this.totalSignals,
    required this.successRate,
  });

  factory TraderStats.fromJson(Map<String, dynamic> json) {
    return TraderStats(
      totalMembers: json['total_members'] ?? 0,
      monthlyRevenue: json['monthly_revenue'] ?? 0,
      totalSignals: json['total_signals'] ?? 0,
      successRate: json['success_rate']?.toString() ?? '0.00',
    );
  }
}

class TraderSubscriptionInfo {
  final String planName;
  final int activeGroups;
  final bool isUnlimitedGroups;
  final int totalGroupsLimit;
  final int totalMembers;
  final bool isUnlimitedMembers;
  final int membersLimit;
  final String expireDate;
  final int daysLeft;

  TraderSubscriptionInfo({
    required this.planName,
    required this.activeGroups,
    required this.isUnlimitedGroups,
    required this.totalGroupsLimit,
    required this.totalMembers,
    required this.isUnlimitedMembers,
    required this.membersLimit,
    required this.expireDate,
    required this.daysLeft,
  });

  factory TraderSubscriptionInfo.fromJson(Map<String, dynamic> json) {
    return TraderSubscriptionInfo(
      planName: json['plan_name'] ?? '',
      activeGroups: json['active_groups'] ?? 0,
      isUnlimitedGroups: json['is_unlimited_groups'] ?? false,
      totalGroupsLimit: json['total_groups_limit'] ?? 0,
      totalMembers: json['total_members'] ?? 0,
      isUnlimitedMembers: json['is_unlimited_members'] ?? false,
      membersLimit: json['members_limit'] ?? 0,
      expireDate: json['expire_date'] ?? '',
      daysLeft: json['days_left'] ?? 0,
    );
  }
}

class TraderGroup {
  final int id;
  final String name;
  final String? groupIcon;
  final int members;
  final int limit;
  final dynamic monthlyRevenue;
  final dynamic growthRate;

  TraderGroup({
    required this.id,
    required this.name,
    this.groupIcon,
    required this.members,
    required this.limit,
    required this.monthlyRevenue,
    required this.growthRate,
  });

  factory TraderGroup.fromJson(Map<String, dynamic> json) {
    return TraderGroup(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      groupIcon: json['group_icon'] as String?,
      members: json['members'] ?? 0,
      limit: json['limit'] ?? 0,
      monthlyRevenue: json['monthly_revenue'] ?? 0,
      growthRate: json['growth_rate'] ?? 0,
    );
  }
}
