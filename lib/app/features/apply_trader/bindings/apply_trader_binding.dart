import 'package:get/get.dart';

import '../viewmodel/apply_trader_view_model.dart';

class ApplyTraderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyTraderViewModel>(() => ApplyTraderViewModel());
  }
}
