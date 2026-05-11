import 'package:get/get.dart';
import '../viewmodel/withdraw_view_model.dart';

class WithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawViewModel>(() => WithdrawViewModel());
  }
}
