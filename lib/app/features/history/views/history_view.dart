import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/history_view_model.dart';

class HistoryView extends GetView<HistoryViewModel> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.text, size: 20),
            onPressed: () => Get.back(),
          ),
          title: Obx(() => Text(
                controller.currentTab.value == 2 ? 'Earnings History' : 'Transaction History',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.tune, color: Colors.white, size: 18),
                onPressed: () {},
              ),
            ),
          ],
          bottom: TabBar(
            onTap: controller.setTab,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.mutedText,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: [
              const Tab(text: 'Deposits'),
              const Tab(text: 'Withdrawals'),
              const Tab(text: 'Earnings'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildDepositList(),
            _buildWithdrawList(),
            _buildEarningsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDepositList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.deposits.length,
      itemBuilder: (context, index) {
        final item = controller.deposits[index];
        return _TransactionCard(
          title: item['title']!,
          txn: item['txn']!,
          date: item['date']!,
          amount: item['amount']!,
          status: item['status']!,
          isDeposit: true,
        );
      },
    );
  }

  Widget _buildWithdrawList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.withdrawals.length,
      itemBuilder: (context, index) {
        final item = controller.withdrawals[index];
        return _TransactionCard(
          title: item['title']!,
          txn: item['txn']!,
          date: item['date']!,
          amount: item['amount']!,
          status: item['status']!,
          isDeposit: false,
        );
      },
    );
  }

  Widget _buildEarningsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _EarningsStatsCard(),
          const SizedBox(height: 24),
          ...controller.earnings.map((item) => _EarningsCard(
                title: item['title']!,
                subtitle: item['subtitle']!,
                date: item['date']!,
                amount: item['amount']!,
                status: item['status']!,
                type: item['type']!,
              )),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 20),
            label: Text(
              'Load More',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final String title;
  final String txn;
  final String date;
  final String amount;
  final String status;
  final bool isDeposit;

  const _TransactionCard({
    required this.title,
    required this.txn,
    required this.date,
    required this.amount,
    required this.status,
    required this.isDeposit,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = status == 'Completed'
        ? AppColors.success
        : (status == 'Pending' ? const Color(0xFFEAB308) : AppColors.error);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (isDeposit ? AppColors.success : AppColors.error).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isDeposit ? AppColors.success : AppColors.error,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  txn,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: isDeposit ? AppColors.success : AppColors.error,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EarningsStatsCard extends StatelessWidget {
  const _EarningsStatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          _buildStat('Total Earned', '\$3,210.00'),
          _buildDivider(),
          _buildStat('This Week', '\$320.00'),
          _buildDivider(),
          _buildStat('Today', '\$48.50'),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.mutedText, fontSize: 11),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 30,
      color: AppColors.border,
    );
  }
}

class _EarningsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final String status;
  final String type;

  const _EarningsCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;
    
    switch (type) {
      case 'roi':
        icon = Icons.link;
        iconColor = AppColors.primary;
        break;
      case 'bonus':
        icon = Icons.star_outline;
        iconColor = const Color(0xFFEAB308);
        break;
      case 'referral':
        icon = Icons.people_outline;
        iconColor = Colors.teal;
        break;
      default:
        icon = Icons.attach_money;
        iconColor = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
