import 'package:get/get.dart';

import '../../../core/services/session_service.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';
import '../viewmodel/edit_profile_view_model.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileViewModel>(
      () => EditProfileViewModel(
        profileRepository: Get.find<ProfileRepository>(),
        sessionService: Get.find<SessionService>(),
      ),
    );
  }
}
