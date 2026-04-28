import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/trader_account_view_model.dart';

class TraderAccountView extends GetView<TraderAccountViewModel> {
  const TraderAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TraderAccountBody();
  }
}

class _TraderAccountBody extends StatefulWidget {
  const _TraderAccountBody();

  @override
  State<_TraderAccountBody> createState() => _TraderAccountBodyState();
}

class _TraderAccountBodyState extends State<_TraderAccountBody> {
  bool showWithdraw = false;
  String? crypto;
  final wallet = TextEditingController();
  final amount = TextEditingController();

  @override
  void dispose() {
    wallet.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cryptos = [
      {
        'id': 'btc',
        'name': 'Bitcoin',
        'symbol': 'BTC',
        'icon': '₿',
        'fee': '\$2.50',
        'min': '\$50',
      },
      {
        'id': 'eth',
        'name': 'Ethereum',
        'symbol': 'ETH',
        'icon': 'Ξ',
        'fee': '\$1.80',
        'min': '\$30',
      },
      {
        'id': 'usdt',
        'name': 'Tether',
        'symbol': 'USDT',
        'icon': '₮',
        'fee': '\$1.00',
        'min': '\$20',
      },
      {
        'id': 'bnb',
        'name': 'Binance Coin',
        'symbol': 'BNB',
        'icon': 'B',
        'fee': '\$0.50',
        'min': '\$25',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trader Profile',),
        backgroundColor: AppColors.background,
        centerTitle: true,
        surfaceTintColor: AppColors.background,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: AppColors.text,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
Get.toNamed(AppRoutes.traderEditProfile);
            },
            child: Icon(Icons.edit, size: 18, color: AppColors.text)),
          const SizedBox(width: 20),
        ],
        
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
         
            const Row(
              children: [
                _HeadAvatar(),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Martinez',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Professional Trader',
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    _Verified(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            MarketPanel(
              radius: 18,
              color: AppColors.primary.withValues(alpha: 0.1),
              borderColor: AppColors.primary.withValues(alpha: 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total Earnings',
                    style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '\$14,715',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _Small(label: 'This Month', value: '\$8,415'),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _Small(label: 'Last Month', value: '\$6,300'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        '+33.5% growth this month',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.traderSubscription),
              child: MarketPanel(
                radius: 16,
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF059669), Color(0xFF34D399)],
                        ),
                      ),
                      child: const Icon(Icons.workspace_premium),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pro Plan',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\$79/month',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Upgrade',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Withdraw',
                    icon: const Icon(Icons.account_balance_wallet, size: 14),
                    onTap: () => setState(() => showWithdraw = !showWithdraw),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.traderInbox),
                    child: const MarketPanel(
                      radius: 12,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail_outline, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text(
                            'Inbox',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.createGroup),
                    child: const MarketPanel(
                      radius: 12,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text(
                            'Create',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (showWithdraw) ...[
              const SizedBox(height: 12),
              const Text(
                'Select Crypto Method',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cryptos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (_, i) {
                  final c = cryptos[i];
                  final active = crypto == c['id'];
                  return InkWell(
                    onTap: () => setState(() => crypto = c['id']! as String),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.card,
                        border: Border.all(
                          color: active ? AppColors.primary : AppColors.border,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.accent],
                              ),
                            ),
                            child: Text(
                              c['icon']! as String,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            c['name']! as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Fee: ${c['fee']}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (crypto != null) ...[
                const SizedBox(height: 8),
                const MarketTextInput(
                  label: 'Amount (USD)',
                  hint: 'Enter amount',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                MarketTextInput(
                  label: 'Wallet Address',
                  hint: 'Paste your wallet address',
                  controller: wallet,
                ),
                const SizedBox(height: 8),
                PrimaryButton(label: 'Confirm Withdrawal', onTap: () {}),
              ],
            ],
            const SizedBox(height: 12),
            const Text(
              'Performance Stats',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Expanded(
                  child: _Stat(
                    label: 'Members',
                    value: '1,270',
                    icon: Icons.groups,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _Stat(
                    label: 'Avg. ROI',
                    value: '+94%',
                    icon: Icons.trending_up,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _Stat(
                    label: 'Success',
                    value: '78%',
                    icon: Icons.bar_chart,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Recent Withdrawals',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...[
              {'date': 'Mar 25, 2026', 'amount': '\$2,450', 'method': 'BTC'},
              {'date': 'Mar 18, 2026', 'amount': '\$3,200', 'method': 'ETH'},
              {'date': 'Mar 10, 2026', 'amount': '\$1,890', 'method': 'USDT'},
            ].map(
              (t) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MarketPanel(
                  radius: 12,
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['amount']! as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              t['date']! as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              'completed',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Text(
                            t['method']! as String,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.mutedText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeadAvatar extends StatelessWidget {
  const _HeadAvatar();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
      ),
      child: const Text('👨‍💼', style: TextStyle(fontSize: 36)),
    );
  }
}

class _Verified extends StatelessWidget {
  const _Verified();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'Verified ✓',
        style: TextStyle(
          color: Colors.green,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Small extends StatelessWidget {
  const _Small({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppColors.mutedText),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return MarketPanel(
      radius: 12,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text(
            label,
            style: const TextStyle(color: AppColors.mutedText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
