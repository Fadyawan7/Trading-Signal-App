import 'package:get/get.dart';

import '../../../core/services/session_service.dart';
import '../../auth/domain/repositories/auth_repository.dart';
import '../viewmodel/user_profile_view_model.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileViewModel>(
      () => UserProfileViewModel(
        authRepository: Get.find<AuthRepository>(),
        sessionService: Get.find<SessionService>(),
      ),
    );
  }
}
