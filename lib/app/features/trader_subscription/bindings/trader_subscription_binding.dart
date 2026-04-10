import 'package:get/get.dart';

import '../viewmodel/trader_subscription_view_model.dart';

class TraderSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderSubscriptionViewModel>(() => TraderSubscriptionViewModel());
  }
}
