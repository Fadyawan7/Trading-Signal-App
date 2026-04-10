import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/subscription_payment_view_model.dart';

class SubscriptionPaymentView extends GetView<SubscriptionPaymentViewModel> {
  const SubscriptionPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SubscriptionPaymentBody();
  }
}

class _SubscriptionPaymentBody extends StatefulWidget {
  const _SubscriptionPaymentBody();

  @override
  State<_SubscriptionPaymentBody> createState() =>
      _SubscriptionPaymentBodyState();
}

class _SubscriptionPaymentBodyState extends State<_SubscriptionPaymentBody> {
  String? method;
  String? crypto;

  @override
  Widget build(BuildContext context) {
    final args =
        (Get.arguments as Map<String, dynamic>?) ??
        {'plan': 'Pro', 'price': '\$79', 'billing': 'monthly'};
    const cryptos = [
      {'id': 'btc', 'name': 'Bitcoin', 'symbol': 'BTC', 'icon': '₿'},
      {'id': 'eth', 'name': 'Ethereum', 'symbol': 'ETH', 'icon': 'Ξ'},
      {'id': 'usdt', 'name': 'Tether', 'symbol': 'USDT', 'icon': '₮'},
      {'id': 'bnb', 'name': 'Binance Coin', 'symbol': 'BNB', 'icon': 'B'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconSquare(icon: Icons.arrow_back, onTap: Get.back),
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 12),
                MarketPanel(
                  radius: 18,
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderColor: AppColors.primary.withValues(alpha: 0.2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selected Plan',
                              style: TextStyle(
                                color: AppColors.mutedText,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              args['plan'] as String,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            args['price'] as String,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '/${args['billing']}',
                            style: const TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Choose Payment Method',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                _method(
                  'card',
                  Icons.credit_card,
                  'Credit/Debit Card',
                  'Visa, Mastercard, Amex',
                ),
                const SizedBox(height: 8),
                _method(
                  'crypto',
                  Icons.account_balance_wallet_outlined,
                  'Cryptocurrency',
                  'BTC, ETH, USDT, BNB',
                ),
                const SizedBox(height: 8),
                _method(
                  'bank',
                  Icons.account_balance,
                  'Bank Transfer',
                  'Direct bank transfer',
                ),
                if (method == 'card') ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Card Details',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const MarketTextInput(
                    label: 'Card Number',
                    hint: '1234 5678 9012 3456',
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Expanded(
                        child: MarketTextInput(
                          label: 'Expiry Date',
                          hint: 'MM/YY',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: MarketTextInput(label: 'CVV', hint: '123'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const MarketTextInput(
                    label: 'Cardholder Name',
                    hint: 'John Doe',
                  ),
                ],
                if (method == 'crypto') ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Select Cryptocurrency',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cryptos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.35,
                        ),
                    itemBuilder: (_, i) {
                      final c = cryptos[i];
                      final selected = crypto == c['id'];
                      return InkWell(
                        onTap: () =>
                            setState(() => crypto = c['id']! as String),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.card,
                            border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.border,
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
                                    colors: [
                                      AppColors.primary,
                                      AppColors.accent,
                                    ],
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
                                c['symbol']! as String,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.mutedText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                if (method == 'bank') ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Bank Transfer Details',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const MarketPanel(
                    radius: 14,
                    child: Column(
                      children: [
                        _Line(
                          label: 'Account Name',
                          value: 'TradeConnect Inc.',
                        ),
                        _Line(label: 'Account Number', value: '1234567890'),
                        _Line(label: 'Bank Name', value: 'Global Bank'),
                        _Line(label: 'SWIFT Code', value: 'GLBNPKKX'),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                const MarketPanel(
                  radius: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        '256-bit SSL Encrypted Payment',
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (method != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.95),
                    border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        label: 'Pay ${args['price']}',
                        icon: const Icon(Icons.lock, size: 16),
                        onTap: (method != 'crypto' || crypto != null)
                            ? () => Get.offAllNamed(AppRoutes.traderDashboard)
                            : null,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'By continuing, you agree to our Terms of Service',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _method(String id, IconData icon, String title, String sub) {
    final active = method == id;
    return InkWell(
      onTap: () => setState(() => method = id),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.card,
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    sub,
                    style: const TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (active)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.mutedText, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
