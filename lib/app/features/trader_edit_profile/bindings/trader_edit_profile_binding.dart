import 'package:get/get.dart';

import '../viewmodel/trader_edit_profile_view_model.dart';

class TraderEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderEditProfileViewModel>(() => TraderEditProfileViewModel());
  }
}
