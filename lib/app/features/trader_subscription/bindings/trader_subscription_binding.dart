import 'package:get/get.dart';

import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../viewmodel/trader_subscription_view_model.dart';

class TraderSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderSubscriptionViewModel>(
      () => TraderSubscriptionViewModel(
        traderRepository: Get.find<TraderRepository>(),
      ),
    );
  }
}


