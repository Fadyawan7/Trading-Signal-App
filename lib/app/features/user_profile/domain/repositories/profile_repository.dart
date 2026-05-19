import '../../data/models/profile_response.dart';
import '../../data/models/user_roles_response.dart';

abstract class ProfileRepository {
  Future<UserRolesResponse> getUserRoles();
  Future<ProfileResponse> getProfile();
  Future<ProfileResponse> updateProfile({
    required String name,
    required String bio,
    String? avatar,
  });
}

