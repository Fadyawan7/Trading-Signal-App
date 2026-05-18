import 'package:get/get.dart';
import '../../auth/domain/repositories/auth_repository.dart';

import '../../../core/services/session_service.dart';
import '../domain/repositories/profile_repository.dart';
import '../viewmodel/user_profile_view_model.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileViewModel>(
      () => UserProfileViewModel(
        authRepository: Get.find<AuthRepository>(),
        profileRepository: Get.find<ProfileRepository>(),
        sessionService: Get.find<SessionService>(),
      ),
    );
  }
}
