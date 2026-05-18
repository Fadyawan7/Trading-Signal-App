import '../../data/models/profile_response.dart';

abstract class ProfileRepository {
  Future<ProfileResponse> getProfile();
  Future<ProfileResponse> updateProfile({
    required String name,
    required String bio,
    String? avatar,
  });
}
