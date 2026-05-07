class AuthRole {
  AuthRole({
    required this.id,
    required this.name,
    required this.displayName,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String displayName;
  final String createdAt;
  final String updatedAt;

  factory AuthRole.fromJson(Map<String, dynamic> json) {
    return AuthRole(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display_name': displayName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
