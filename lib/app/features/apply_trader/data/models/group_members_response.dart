class GroupMembersResponse {
  final bool status;
  final String message;
  final GroupMembersData? data;

  GroupMembersResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory GroupMembersResponse.fromJson(Map<String, dynamic> json) {
    return GroupMembersResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? GroupMembersData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class GroupMembersData {
  final List<GroupMemberItem> list;

  GroupMembersData({required this.list});

  factory GroupMembersData.fromJson(Map<String, dynamic> json) {
    var listData = <GroupMemberItem>[];
    if (json['data'] != null) {
      final l = json['data'] as List;
      listData = l.map((e) => GroupMemberItem.fromJson(e as Map<String, dynamic>)).toList();
    }
    return GroupMembersData(list: listData);
  }
}

class GroupMemberItem {
  final int groupMemberId;
  final int groupId;
  final MemberUser user;
  final String role; // "owner", "admin", "member"
  final String joinedAt;

  GroupMemberItem({
    required this.groupMemberId,
    required this.groupId,
    required this.user,
    required this.role,
    required this.joinedAt,
  });

  factory GroupMemberItem.fromJson(Map<String, dynamic> json) {
    return GroupMemberItem(
      groupMemberId: json['group_member_id'] ?? 0,
      groupId: json['group_id'] ?? 0,
      user: MemberUser.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      role: json['role'] ?? 'member',
      joinedAt: json['joined_at'] ?? '',
    );
  }
}

class MemberUser {
  final int userId;
  final String name;
  final String email;

  MemberUser({
    required this.userId,
    required this.name,
    required this.email,
  });

  factory MemberUser.fromJson(Map<String, dynamic> json) {
    return MemberUser(
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
