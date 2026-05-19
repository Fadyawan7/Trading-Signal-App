class AllTraderGroupsResponse {
  final bool status;
  final String message;
  final AllTraderGroupsData? data;

  AllTraderGroupsResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory AllTraderGroupsResponse.fromJson(Map<String, dynamic> json) {
    return AllTraderGroupsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? AllTraderGroupsData.fromJson(json['data']) : null,
    );
  }
}

class AllTraderGroupsData {
  final List<TraderGroupItem> data;
  final AllTraderGroupsLinks? links;
  final AllTraderGroupsMeta? meta;

  AllTraderGroupsData({
    required this.data,
    this.links,
    this.meta,
  });

  factory AllTraderGroupsData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<TraderGroupItem> itemList = list.map((i) => TraderGroupItem.fromJson(i)).toList();

    return AllTraderGroupsData(
      data: itemList,
      links: json['links'] != null ? AllTraderGroupsLinks.fromJson(json['links']) : null,
      meta: json['meta'] != null ? AllTraderGroupsMeta.fromJson(json['meta']) : null,
    );
  }
}

class TraderGroupItem {
  final int groupId;
  final String groupName;
  final String? groupIcon;
  final String? lastMessage;
  final String? lastMessageTime;
  final int unreadMessagesCount;
  final int membersCount;
  final String role;

  TraderGroupItem({
    required this.groupId,
    required this.groupName,
    this.groupIcon,
    this.lastMessage,
    this.lastMessageTime,
    required this.unreadMessagesCount,
    required this.membersCount,
    required this.role,
  });

  factory TraderGroupItem.fromJson(Map<String, dynamic> json) {
    return TraderGroupItem(
      groupId: json['group_id'] is num ? (json['group_id'] as num).toInt() : 0,
      groupName: json['group_name'] ?? '',
      groupIcon: json['group_icon'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'],
      unreadMessagesCount: json['unread_messages_count'] is num ? (json['unread_messages_count'] as num).toInt() : 0,
      membersCount: json['members_count'] is num ? (json['members_count'] as num).toInt() : 0,
      role: json['role'] ?? '',
    );
  }
}

class AllTraderGroupsLinks {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  AllTraderGroupsLinks({this.first, this.last, this.prev, this.next});

  factory AllTraderGroupsLinks.fromJson(Map<String, dynamic> json) {
    return AllTraderGroupsLinks(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}

class AllTraderGroupsMeta {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

  AllTraderGroupsMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory AllTraderGroupsMeta.fromJson(Map<String, dynamic> json) {
    return AllTraderGroupsMeta(
      currentPage: json['current_page'] is num ? (json['current_page'] as num).toInt() : 1,
      from: json['from'] is num ? (json['from'] as num).toInt() : 1,
      lastPage: json['last_page'] is num ? (json['last_page'] as num).toInt() : 1,
      path: json['path'] ?? '',
      perPage: json['per_page'] is num ? (json['per_page'] as num).toInt() : 10,
      to: json['to'] is num ? (json['to'] as num).toInt() : 0,
      total: json['total'] is num ? (json['total'] as num).toInt() : 0,
    );
  }
}
