class SubscriptionPlan {
  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.allow_groups,
    required this.is_unlimited_groups,
    required this.allow_members,
    required this.is_unlimited_members,
    required this.description,
    required this.icon,
    required this.status,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String type;
  final double price;
  final int allow_groups;
  final bool is_unlimited_groups;
  final int allow_members;
  final bool is_unlimited_members;
  final List<String> description;
  final String icon;
  final String status;
  final String createdAt;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      allow_groups: json['allow_groups'] as int? ?? 0,
      is_unlimited_groups: json['is_unlimited_groups'] == true,
      allow_members: json['allow_members'] as int? ?? 0,
      is_unlimited_members: json['is_unlimited_members'] == true,
      description: (json['description'] as List?)?.map((e) => e.toString()).toList() ?? [],
      icon: json['icon']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}

class TraderSubscriptionPlansResponse {
  TraderSubscriptionPlansResponse({
    required this.status,
    required this.message,
    required this.plans,
    this.meta,
  });

  final bool status;
  final String message;
  final List<SubscriptionPlan> plans;
  final PaginationMeta? meta;

  factory TraderSubscriptionPlansResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    List<SubscriptionPlan> planList = [];
    PaginationMeta? parsedMeta;

    if (data is Map<String, dynamic>) {
      final list = data['data'] as List?;
      if (list != null) {
        planList = list.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>)).toList();
      }
      if (data['meta'] != null) {
        parsedMeta = PaginationMeta.fromJson(data['meta'] as Map<String, dynamic>);
      }
    } else if (data is List) {
      planList = data.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>)).toList();
    }

    return TraderSubscriptionPlansResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      plans: planList,
      meta: parsedMeta,
    );
  }
}

class PaginationMeta {
  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
    );
  }
}
