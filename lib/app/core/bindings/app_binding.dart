import 'package:get/get.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/user_profile/data/datasources/profile_remote_data_source.dart';
import '../../features/user_profile/data/repositories/profile_repository_impl.dart';
import '../../features/user_profile/domain/repositories/profile_repository.dart';
import '../../features/apply_trader/data/datasources/trader_remote_data_source.dart';
import '../../features/apply_trader/data/repositories/trader_repository_impl.dart';
import '../../features/apply_trader/domain/repositories/trader_repository.dart';
import '../network/api_client.dart';
import '../services/app_feedback_service.dart';
import '../services/session_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppFeedbackService>(AppFeedbackService(), permanent: true);
    Get.put<ApiClient>(ApiClient(), permanent: true);
    final sessionService = Get.find<SessionService>();
    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSource(
        apiClient: Get.find<ApiClient>(),
        sessionService: sessionService,
      ),
      permanent: true,
    );
    Get.put<AuthRepository>(
      AuthRepositoryImpl(remoteDataSource: Get.find<AuthRemoteDataSource>()),
      permanent: true,
    );
    Get.put<ProfileRemoteDataSource>(
      ProfileRemoteDataSource(
        apiClient: Get.find<ApiClient>(),
        sessionService: sessionService,
      ),
      permanent: true,
    );
    Get.put<ProfileRepository>(
      ProfileRepositoryImpl(
        remoteDataSource: Get.find<ProfileRemoteDataSource>(),
      ),
      permanent: true,
    );

    // Trader registrations
    Get.put<TraderRemoteDataSource>(
      TraderRemoteDataSource(
        apiClient: Get.find<ApiClient>(),
        sessionService: sessionService,
      ),
      permanent: true,
    );
    Get.put<TraderRepository>(
      TraderRepositoryImpl(
        remoteDataSource: Get.find<TraderRemoteDataSource>(),
      ),
      permanent: true,
    );
  }
}

