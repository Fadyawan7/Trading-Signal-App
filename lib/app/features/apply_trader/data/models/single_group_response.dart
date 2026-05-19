class SingleGroupResponse {
  final bool status;
  final String message;
  final SingleGroupData? data;

  SingleGroupResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory SingleGroupResponse.fromJson(Map<String, dynamic> json) {
    return SingleGroupResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SingleGroupData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class SingleGroupData {
  final int id;
  final String groupName;
  final String? groupIcon;
  final int categoryId;
  final bool isPaid;
  final dynamic price;
  final bool hasTrial;
  final int trialDays;
  final String? duration;
  final int maximumMembers;
  final String description;
  final List<String> groupFeature;
  final bool onlyAdminCanMessage;
  final String? monthlyRevenue;
  final dynamic growthRate;
  final String? createdAt;
  final String? updatedAt;
  final int membersCount;
  final dynamic averageRating;
  final int reviewsCount;

  SingleGroupData({
    required this.id,
    required this.groupName,
    this.groupIcon,
    required this.categoryId,
    required this.isPaid,
    this.price,
    required this.hasTrial,
    required this.trialDays,
    this.duration,
    required this.maximumMembers,
    required this.description,
    required this.groupFeature,
    required this.onlyAdminCanMessage,
    this.monthlyRevenue,
    this.growthRate,
    this.createdAt,
    this.updatedAt,
    required this.membersCount,
    this.averageRating,
    required this.reviewsCount,
  });

  factory SingleGroupData.fromJson(Map<String, dynamic> json) {
    final featuresList = <String>[];
    if (json['group_feature'] != null) {
      final list = json['group_feature'] as List;
      featuresList.addAll(list.map((e) => e.toString()));
    }
    return SingleGroupData(
      id: json['id'] ?? 0,
      groupName: json['group_name'] ?? '',
      groupIcon: json['group_icon'] as String?,
      categoryId: json['category_id'] ?? 0,
      isPaid: json['is_paid'] == true || json['is_paid'] == 1,
      price: json['price'],
      hasTrial: json['has_trial'] == true || json['has_trial'] == 1,
      trialDays: json['trial_days'] ?? 0,
      duration: json['duration']?.toString(),
      maximumMembers: json['maximum_members'] ?? 0,
      description: json['description'] ?? '',
      groupFeature: featuresList,
      onlyAdminCanMessage: json['only_admin_can_message'] == true || json['only_admin_can_message'] == 1 || json['only_admin_can_message'] == '1',
      monthlyRevenue: json['monthly_revenue']?.toString(),
      growthRate: json['growth_rate'],
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      membersCount: json['members_count'] ?? 0,
      averageRating: json['average_rating'],
      reviewsCount: json['reviews_count'] ?? 0,
    );
  }
}
