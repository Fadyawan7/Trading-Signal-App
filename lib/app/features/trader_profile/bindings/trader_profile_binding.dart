import 'package:get/get.dart';

import '../viewmodel/trader_profile_view_model.dart';

class TraderProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderProfileViewModel>(() => TraderProfileViewModel());
  }
}
