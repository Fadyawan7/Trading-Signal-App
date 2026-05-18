import 'subscription_plan.dart';

class MySubscription {
  MySubscription({
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
    required this.startDate,
    required this.expireDate,
    required this.isExpire,
    required this.remainingDays,
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
  final String startDate;
  final String expireDate;
  final bool isExpire;
  final int remainingDays;

  factory MySubscription.fromJson(Map<String, dynamic> json) {
    return MySubscription(
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
      startDate: json['start_date']?.toString() ?? '',
      expireDate: json['expire_date']?.toString() ?? '',
      isExpire: json['is_expire'] == true,
      remainingDays: json['remaining_days'] as int? ?? 0,
    );
  }
}

class MySubscriptionsResponse {
  MySubscriptionsResponse({
    required this.status,
    required this.message,
    required this.subscriptions,
    this.meta,
  });

  final bool status;
  final String message;
  final List<MySubscription> subscriptions;
  final PaginationMeta? meta;

  factory MySubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    List<MySubscription> subscriptionList = [];
    PaginationMeta? parsedMeta;

    if (data is Map<String, dynamic>) {
      final list = data['data'] as List?;
      if (list != null) {
        subscriptionList = list.map((e) => MySubscription.fromJson(e as Map<String, dynamic>)).toList();
      }
      if (data['meta'] != null) {
        parsedMeta = PaginationMeta.fromJson(data['meta'] as Map<String, dynamic>);
      }
    } else if (data is List) {
      subscriptionList = data.map((e) => MySubscription.fromJson(e as Map<String, dynamic>)).toList();
    }

    return MySubscriptionsResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      subscriptions: subscriptionList,
      meta: parsedMeta,
    );
  }
}
