import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';

class HistoryViewModel extends BaseViewModel {
  final currentTab = 0.obs;

  void setTab(int index) {
    currentTab.value = index;
  }

  // Mock data for Deposit
  final deposits = [
    {'title': 'Deposit', 'txn': 'TXN#00462931', 'date': 'Oct 12, 2025 - 14:32', 'amount': '+500.00', 'status': 'Completed'},
    {'title': 'Deposit', 'txn': 'TXN#00462945', 'date': 'Oct 11, 2025 - 09:18', 'amount': '+1,200.00', 'status': 'Pending'},
  ].obs;

  // Mock data for Withdraw
  final withdrawals = [
    {'title': 'Withdraw', 'txn': 'TXN#00462952', 'date': 'Oct 10, 2025 - 18:47', 'amount': '-300.00', 'status': 'Completed'},
    {'title': 'Withdraw', 'txn': 'TXN#00462968', 'date': 'Oct 09, 2025 - 11:05', 'amount': '-150.00', 'status': 'Failed'},
  ].obs;

  // Mock data for Earnings
  final earnings = [
    {'title': 'Daily Earnings', 'subtitle': 'ROI Reward — Day 12', 'date': 'Today, 09:15 AM', 'amount': '+\$48.50', 'status': 'Completed', 'type': 'roi'},
    {'title': 'Weekly Bonus', 'subtitle': 'Performance Bonus', 'date': 'Mon, 08:00 AM', 'amount': '+\$120.00', 'status': 'Completed', 'type': 'bonus'},
    {'title': 'Referral Reward', 'subtitle': 'Level 1 Bonus Income', 'date': 'Sun, 03:42 PM', 'amount': '+\$25.00', 'status': 'Completed', 'type': 'referral'},
    {'title': 'Daily Earnings', 'subtitle': 'ROI Reward — Day 11', 'date': 'Sat, 09:10 AM', 'amount': '+\$47.80', 'status': 'Completed', 'type': 'roi'},
  ].obs;
}
