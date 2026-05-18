import 'package:get/get.dart';

import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../viewmodel/subscription_payment_view_model.dart';

class SubscriptionPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionPaymentViewModel>(
      () => SubscriptionPaymentViewModel(
        traderRepository: Get.find<TraderRepository>(),
      ),
    );
  }
}


