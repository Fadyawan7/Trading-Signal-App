import '../../data/models/user_roles_response.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_response.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<UserRolesResponse> getUserRoles() {
    return _remoteDataSource.getUserRoles();
  }

  @override
  Future<ProfileResponse> getProfile() {

    return _remoteDataSource.getProfile();
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String name,
    required String bio,
    String? avatar,
  }) {
    return _remoteDataSource.updateProfile(
      name: name,
      bio: bio,
      avatar: avatar,
    );
  }
}
