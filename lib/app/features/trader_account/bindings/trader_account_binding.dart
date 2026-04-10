import 'package:get/get.dart';

import '../viewmodel/trader_account_view_model.dart';

class TraderAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderAccountViewModel>(() => TraderAccountViewModel());
  }
}
