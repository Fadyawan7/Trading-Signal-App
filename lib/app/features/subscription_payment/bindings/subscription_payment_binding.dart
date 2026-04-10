import 'package:get/get.dart';

import '../viewmodel/subscription_payment_view_model.dart';

class SubscriptionPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionPaymentViewModel>(() => SubscriptionPaymentViewModel());
  }
}
