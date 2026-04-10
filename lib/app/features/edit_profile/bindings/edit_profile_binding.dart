import 'package:get/get.dart';

import '../viewmodel/edit_profile_view_model.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileViewModel>(() => EditProfileViewModel());
  }
}
