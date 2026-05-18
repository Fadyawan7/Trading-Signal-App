import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_loading_overlay.dart';

import '../viewmodel/subscription_payment_view_model.dart';

class SubscriptionPaymentView extends GetView<SubscriptionPaymentViewModel> {
  const SubscriptionPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        message: 'Processing subscription...',
        child: const _SubscriptionPaymentBody(),
      ),
    );
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
    final controller = Get.find<SubscriptionPaymentViewModel>();
    final args = (Get.arguments as Map<String, dynamic>?) ??
        {'plan': 'Pro', 'price': '\$79', 'billing': 'weekly', 'plan_id': '9'};
        
    final List<Map<String, dynamic>> cryptos = [
      {'id': 'btc', 'name': 'Bitcoin', 'symbol': 'BTC', 'icon': Icons.currency_bitcoin_rounded, 'color': const Color(0xFFF7931A)},
      {'id': 'eth', 'name': 'Ethereum', 'symbol': 'ETH', 'icon': Icons.eco_rounded, 'color': const Color(0xFF627EEA)},
      {'id': 'usdt', 'name': 'Tether', 'symbol': 'USDT', 'icon': Icons.attach_money_rounded, 'color': const Color(0xFF26A17B)},
      {'id': 'bnb', 'name': 'Binance', 'symbol': 'BNB', 'icon': Icons.currency_bitcoin_rounded, 'color': const Color(0xFFF3BA2F)},
    ];

    return Obx(() {
      AppColors.background;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _Header(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  children: [
                    _SummaryCard(args: args),
                    const SizedBox(height: 24),
                    _SectionTitle('Choose Payment Method'),
                    const SizedBox(height: 12),
                    _PaymentMethodTile(
                      id: 'card',
                      icon: Icons.credit_card_rounded,
                      title: 'Credit/Debit Card',
                      subtitle: 'Visa, Mastercard, Amex',
                      isSelected: method == 'card',
                      onSelect: () => setState(() => method = 'card'),
                      iconColor: const Color(0xFF627EEA),
                    ),
                    const SizedBox(height: 12),
                    _PaymentMethodTile(
                      id: 'crypto',
                      icon: Icons.account_balance_wallet_rounded,
                      title: 'Cryptocurrency',
                      subtitle: 'BTC, ETH, USDT, BNB',
                      isSelected: method == 'crypto',
                      onSelect: () => setState(() => method = 'crypto'),
                      iconColor: const Color(0xFFF59E0B),
                    ),
                    const SizedBox(height: 12),
                    _PaymentMethodTile(
                      id: 'bank',
                      icon: Icons.account_balance_rounded,
                      title: 'Bank Transfer',
                      subtitle: 'Direct bank transfer',
                      isSelected: method == 'bank',
                      onSelect: () => setState(() => method = 'bank'),
                      iconColor: const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 24),
                    
                    if (method == 'card') ...[
                      _SectionTitle('Card Details'),
                      const SizedBox(height: 12),
                      _InputField(label: 'Card Number', hint: '1234 5678 9012 3456'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _InputField(label: 'Expiry Date', hint: 'MM/YY')),
                          const SizedBox(width: 12),
                          Expanded(child: _InputField(label: 'CVV', hint: '123')),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _InputField(label: 'Cardholder Name', hint: 'John Doe'),
                    ],

                    if (method == 'crypto') ...[
                      _SectionTitle('Select Cryptocurrency'),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cryptos.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.4,
                        ),
                        itemBuilder: (_, i) {
                          final c = cryptos[i];
                          final isSelected = crypto == c['id'];
                          final color = c['color'] as Color;
                          return InkWell(
                            onTap: () => setState(() => crypto = c['id'] as String),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? color.withOpacity(0.05) : AppColors.card,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? color : AppColors.border,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(c['icon'] as IconData, color: color, size: 28),
                                  const SizedBox(height: 6),
                                  Text(c['name'] as String, style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.bold)),
                                  Text(c['symbol'] as String, style: TextStyle(color: AppColors.mutedText, fontSize: 10)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],

                    if (method == 'bank') ...[
                      _SectionTitle('Bank Transfer Details'),
                      const SizedBox(height: 12),
                      _BankDetailsCard(),
                    ],

                    const SizedBox(height: 24),
                    _SecurityBadge(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              if (method != null) _BottomAction(
                price: args['price'] as String,
                onTap: (method != 'crypto' || crypto != null)
                    ? () => controller.purchaseSubscription(args['plan_id']?.toString() ?? '')
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text, size: 18),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Payment Method',
            style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final Map<String, dynamic> args;
  const _SummaryCard({required this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Plan', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(args['plan'] as String, style: TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(args['price'] as String, style: TextStyle(color: AppColors.text, fontSize: 26, fontWeight: FontWeight.bold)),
                  Text('/${args['billing']}', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF14B8A6).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF14B8A6).withOpacity(0.1)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield_outlined, color: Color(0xFF14B8A6), size: 16),
                SizedBox(width: 8),
                Text('Secure payment • Cancel anytime', style: TextStyle(color: Color(0xFF14B8A6), fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final String id, title, subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelect;
  final Color iconColor;

  const _PaymentMethodTile({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onSelect,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? iconColor.withOpacity(0.05) : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? iconColor : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
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
                  Text(title, style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle_rounded, color: iconColor, size: 22),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label, hint;
  const _InputField({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          style: TextStyle(color: AppColors.text, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF14B8A6), width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _BankDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _DetailLine('Account Name', 'TradeConnect Inc.'),
          _DetailLine('Account Number', '1234567890'),
          _DetailLine('Bank Name', 'Global Bank'),
          _DetailLine('SWIFT Code', 'GLBNPKKX', isLast: true),
        ],
      ),
    );
  }

  Widget _DetailLine(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
          Text(value, style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _SecurityBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_rounded, color: Color(0xFF10B981), size: 14),
          const SizedBox(width: 8),
          Text('256-bit SSL Encrypted Payment', style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final String price;
  final VoidCallback? onTap;

  const _BottomAction({required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                gradient: onTap != null 
                  ? const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF0D9488)])
                  : null,
                color: onTap == null ? AppColors.border : null,
                borderRadius: BorderRadius.circular(12),
                boxShadow: onTap != null 
                  ? [BoxShadow(color: const Color(0xFF10B981).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]
                  : null,
              ),
              child: Center(
                child: Text('Pay $price', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text('By continuing, you agree to our Terms of Service', style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
        ],
      ),
    );
  }
}
