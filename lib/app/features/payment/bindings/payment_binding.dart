import 'package:get/get.dart';

import '../viewmodel/payment_view_model.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentViewModel>(() => PaymentViewModel());
  }
}
