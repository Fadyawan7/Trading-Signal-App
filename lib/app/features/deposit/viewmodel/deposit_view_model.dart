import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';

class DepositViewModel extends BaseViewModel {
  final amount = '0.00'.obs;
  final walletAddress = '0xA3f782627E58C8953189B2c'.obs;
  final network = 'TRC20 (USDT)'.obs;

  void setAmount(String value) {
    amount.value = value;
  }

  void copyAddress() {
    // Mock copy to clipboard
    showSuccess('Address copied to clipboard');
  }
}
