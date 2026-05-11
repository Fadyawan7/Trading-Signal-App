import 'package:get/get.dart';
import '../viewmodel/deposit_view_model.dart';

class DepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DepositViewModel>(() => DepositViewModel());
  }
}
