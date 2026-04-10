import 'package:get/get.dart';

import '../viewmodel/user_profile_view_model.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileViewModel>(() => UserProfileViewModel());
  }
}
