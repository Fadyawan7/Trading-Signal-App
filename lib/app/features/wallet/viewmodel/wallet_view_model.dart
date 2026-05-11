import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';

class WalletViewModel extends BaseViewModel {
  final isBalanceVisible = true.obs;
  
  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }
}
