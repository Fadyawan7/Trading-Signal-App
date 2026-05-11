import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';

class WithdrawViewModel extends BaseViewModel {
  final uid = ''.obs;
  final amount = ''.obs;
  final fee = 1.5.obs;
  
  double get receiveAmount {
    final amt = double.tryParse(amount.value) ?? 0.0;
    return amt > fee.value ? amt - fee.value : 0.0;
  }

  void setUid(String value) => uid.value = value;
  void setAmount(String value) => amount.value = value;

  void showConfirmation() {
    if (uid.isEmpty || amount.isEmpty) {
      showError('Please fill in all fields');
      return;
    }
    // Logic to show dialog will be in the view
  }

  void confirmWithdrawal() {
    showSuccess('Withdrawal request submitted successfully');
    Get.back(); // Close dialog
    Get.back(); // Go back to wallet
  }
}
