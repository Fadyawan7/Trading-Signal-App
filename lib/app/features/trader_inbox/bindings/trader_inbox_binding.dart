import 'package:get/get.dart';

import '../viewmodel/trader_inbox_view_model.dart';

class TraderInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderInboxViewModel>(() => TraderInboxViewModel());
  }
}
