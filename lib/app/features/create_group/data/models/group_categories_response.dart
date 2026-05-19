class GroupCategoriesResponse {
  final bool status;
  final String message;
  final List<GroupCategory> data;

  GroupCategoriesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GroupCategoriesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<GroupCategory> dataList = list.map((i) => GroupCategory.fromJson(i)).toList();
    
    return GroupCategoriesResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: dataList,
    );
  }
}

class GroupCategory {
  final int id;
  final String name;
  final String? icon;
  final String? createdAt;
  final String? updatedAt;

  GroupCategory({
    required this.id,
    required this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupCategory.fromJson(Map<String, dynamic> json) {
    return GroupCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
