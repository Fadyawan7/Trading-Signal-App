import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/payment_view_model.dart';

class PaymentView extends GetView<PaymentViewModel> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PaymentBody();
  }
}

class _PaymentBody extends StatefulWidget {
  const _PaymentBody();

  @override
  State<_PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<_PaymentBody> {
  String selectedMethod = '';

  @override
  Widget build(BuildContext context) {
    final groupId = (Get.arguments?['groupId'] ?? 1).toString();
    const methods = [
      {
        'id': 'crypto',
        'name': 'Crypto Wallet',
        'description': 'Pay with USDT, BTC, or ETH',
        'icon': Icons.account_balance_wallet_outlined,
        'colors': [Color(0xFFF59E0B), Color(0xFFEAB308)],
      },
      {
        'id': 'card',
        'name': 'Credit/Debit Card',
        'description': 'Visa, Mastercard, Amex',
        'icon': Icons.credit_card,
        'colors': [Color(0xFF34D399), Color(0xFF10B981)],
      },
      {
        'id': 'bank',
        'name': 'Bank Transfer',
        'description': 'Direct bank transfer',
        'icon': Icons.account_balance,
        'colors': [Color(0xFF059669), Color(0xFF10B981)],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
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
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  MarketPanel(
                    radius: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12),
                        _SummaryRow(
                          label: 'Group Name',
                          value: 'Crypto Elite Signals',
                        ),
                        _SummaryRow(label: 'Subscription', value: 'Monthly'),
                        _SummaryRow(label: 'Price', value: '\$99.00'),
                        Divider(color: AppColors.border),
                        _SummaryRow(
                          label: 'Total',
                          value: '\$99.00',
                          strong: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  ...methods.map((m) {
                    final active = selectedMethod == m['id'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () =>
                            setState(() => selectedMethod = m['id']! as String),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: active
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: m['colors']! as List<Color>,
                                  ),
                                ),
                                child: Icon(
                                  m['icon']! as IconData,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      m['name']! as String,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      m['description']! as String,
                                      style: TextStyle(
                                        color: AppColors.mutedText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (active)
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  if (selectedMethod == 'card') ...[
                    const SizedBox(height: 8),
                    MarketPanel(
                      radius: 18,
                      child: Column(
                        children: [
                          MarketTextInput(
                            label: 'Card Number',
                            hint: '1234 5678 9012 3456',
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: MarketTextInput(
                                  label: 'Expiry Date',
                                  hint: 'MM/YY',
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: MarketTextInput(
                                  label: 'CVV',
                                  hint: '123',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.22),
                      ),
                    ),
                    child: Text(
                      '🔒 Your payment is secured with 256-bit SSL encryption',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.primary, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Opacity(
                    opacity: selectedMethod.isEmpty ? 0.5 : 1,
                    child: IgnorePointer(
                      ignoring: selectedMethod.isEmpty,
                      child: PrimaryButton(
                        label: 'Complete Payment - \$99.00',
                        onTap: () => Get.offNamed(
                          AppRoutes.groupChat,
                          arguments: {'groupId': groupId},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        'By completing this payment, you agree to our ',
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        ' and ',
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Refund Policy',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.strong = false,
  });

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: strong ? Colors.white : AppColors.mutedText,
              fontWeight: strong ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
