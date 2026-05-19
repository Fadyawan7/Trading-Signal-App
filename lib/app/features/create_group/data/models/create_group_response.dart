class CreateGroupResponse {
  final bool status;
  final String message;
  final CreatedGroupData? data;

  CreateGroupResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? CreatedGroupData.fromJson(json['data']) : null,
    );
  }
}

class CreatedGroupData {
  final int id;
  final String groupName;
  final String? groupIcon;
  final int categoryId;
  final bool isPaid;
  final double price;
  final bool hasTrial;
  final int trialDays;
  final String duration;
  final int maximumMembers;
  final String description;
  final List<String> groupFeature;
  final bool onlyAdminCanMessage;
  final double monthlyRevenue;
  final double growthRate;
  final String createdAt;
  final String updatedAt;
  final int? membersCount;
  final double averageRating;
  final int reviewsCount;

  CreatedGroupData({
    required this.id,
    required this.groupName,
    this.groupIcon,
    required this.categoryId,
    required this.isPaid,
    required this.price,
    required this.hasTrial,
    required this.trialDays,
    required this.duration,
    required this.maximumMembers,
    required this.description,
    required this.groupFeature,
    required this.onlyAdminCanMessage,
    required this.monthlyRevenue,
    required this.growthRate,
    required this.createdAt,
    required this.updatedAt,
    this.membersCount,
    required this.averageRating,
    required this.reviewsCount,
  });

  factory CreatedGroupData.fromJson(Map<String, dynamic> json) {
    var features = json['group_feature'] as List? ?? [];
    List<String> featureList = features.map((f) => f.toString()).toList();

    return CreatedGroupData(
      id: json['id'] ?? 0,
      groupName: json['group_name'] ?? '',
      groupIcon: json['group_icon'],
      categoryId: json['category_id'] is num ? (json['category_id'] as num).toInt() : 0,
      isPaid: json['is_paid'] ?? false,
      price: json['price'] is num ? (json['price'] as num).toDouble() : 0.0,
      hasTrial: json['has_trial'] ?? false,
      trialDays: json['trial_days'] is num ? (json['trial_days'] as num).toInt() : 0,
      duration: json['duration'] ?? 'monthly',
      maximumMembers: json['maximum_members'] is num ? (json['maximum_members'] as num).toInt() : 0,
      description: json['description'] ?? '',
      groupFeature: featureList,
      onlyAdminCanMessage: json['only_admin_can_message'] ?? false,
      monthlyRevenue: json['monthly_revenue'] is num ? (json['monthly_revenue'] as num).toDouble() : 0.0,
      growthRate: json['growth_rate'] is num ? (json['growth_rate'] as num).toDouble() : 0.0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      membersCount: json['members_count'] is num ? (json['members_count'] as num).toInt() : null,
      averageRating: json['average_rating'] is num ? (json['average_rating'] as num).toDouble() : 0.0,
      reviewsCount: json['reviews_count'] is num ? (json['reviews_count'] as num).toInt() : 0,
    );
  }
}
