import 'package:get/get.dart';
import '../viewmodel/wallet_view_model.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletViewModel>(() => WalletViewModel());
  }
}
