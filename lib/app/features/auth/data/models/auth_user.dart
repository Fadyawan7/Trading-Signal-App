import 'auth_role.dart';

class AuthUser {
  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phoneNumber,
    required this.bio,
    required this.avatar,
    required this.profileImage,
    required this.authType,
    required this.uid,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.referralCode,
    required this.inviterId,
    required this.roles,
    required this.token,
  });

  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? phoneNumber;
  final String? bio;
  final String? avatar;
  final String? profileImage;
  final String authType;
  final String uid;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String referralCode;
  final String inviterId;
  final List<AuthRole> roles;
  final String token;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      emailVerifiedAt: json['email_verified_at']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
      bio: json['bio']?.toString(),
      avatar: json['avatar']?.toString(),
      profileImage: json['profile_image']?.toString(),
      authType: json['auth_type']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      referralCode: json['referral_code']?.toString() ?? '',
      inviterId: json['inviter_id']?.toString() ?? '',
      roles: ((json['roles'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(AuthRole.fromJson)
          .toList(),
      token: json['token']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone_number': phoneNumber,
      'bio': bio,
      'avatar': avatar,
      'profile_image': profileImage,
      'auth_type': authType,
      'uid': uid,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'referral_code': referralCode,
      'inviter_id': inviterId,
      'roles': roles.map((role) => role.toJson()).toList(),
      'token': token,
    };
  }
}
