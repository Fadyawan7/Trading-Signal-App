import '../../../../core/network/api_client.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/values/app_constants.dart';
import '../models/profile_response.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource({
    required ApiClient apiClient,
    required SessionService sessionService,
  }) : _apiClient = apiClient,
       _sessionService = sessionService;

  final ApiClient _apiClient;
  final SessionService _sessionService;

  Future<ProfileResponse> getProfile() async {
    final response = await _apiClient.get(
      ApiEndpoints.getProfile,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> updateProfile({
    required String name,
    required String bio,
    String? avatar,
  }) async {
    final fields = {
      'name': name,
      'bio': bio,
      if (avatar != null) 'avatar': avatar,
    };

    final response = await _apiClient.postMultipart(
      ApiEndpoints.updateProfile,
      fields: fields,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return ProfileResponse.fromJson(response);
  }
}
