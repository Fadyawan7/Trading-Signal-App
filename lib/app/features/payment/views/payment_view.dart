import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
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
  String selectedMethod = 'crypto'; // Default to crypto as per screenshot

  @override
  Widget build(BuildContext context) {
    final groupId = (Get.arguments?['groupId'] ?? 1).toString();
    
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Payment Method',
            style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text, size: 16),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const _SummaryRow(label: 'Group Name', value: 'Crypto Elite Signals'),
                    const _SummaryRow(label: 'Subscription', value: 'Monthly'),
                    const _SummaryRow(label: 'Price', value: '\$99.00'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppColors.border, height: 1),
                    ),
                    const _SummaryRow(label: 'Total', value: '\$99.00', isTotal: true),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              Text(
                'Select Payment Method',
                style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Payment Methods
              _PaymentMethodCard(
                id: 'crypto',
                name: 'Crypto Wallet',
                description: 'Pay with USDT, BTC, or ETH',
                icon: Icons.account_balance_wallet_rounded,
                iconBgColor: const Color(0xFFF97316),
                isSelected: selectedMethod == 'crypto',
                onTap: () => setState(() => selectedMethod = 'crypto'),
              ),
              const SizedBox(height: 12),
              _PaymentMethodCard(
                id: 'card',
                name: 'Credit/Debit Card',
                description: 'Visa, Mastercard, Amex',
                icon: Icons.credit_card_rounded,
                iconBgColor: const Color(0xFF14B8A6),
                isSelected: selectedMethod == 'card',
                onTap: () => setState(() => selectedMethod = 'card'),
              ),
              const SizedBox(height: 12),
              _PaymentMethodCard(
                id: 'bank',
                name: 'Bank Transfer',
                description: 'Direct bank transfer',
                icon: Icons.account_balance_rounded,
                iconBgColor: const Color(0xFF10B981),
                isSelected: selectedMethod == 'bank',
                onTap: () => setState(() => selectedMethod = 'bank'),
              ),
              
              const SizedBox(height: 24),
              
              // Security Notice
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 16),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Your payment is secured with 256-bit SSL encryption',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Complete Payment Button
              InkWell(
                onTap: () => Get.offNamed(AppRoutes.groupChat, arguments: {'groupId': groupId}),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Complete Payment - \$99.00',
                      style: TextStyle(
                        color: AppColors.buttonText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Footer Terms
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: AppColors.mutedText, fontSize: 11, height: 1.5),
                      children: [
                        const TextSpan(text: 'By completing this payment, you agree to our '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(color: AppRoutes.login == '/' ? AppColors.primary : AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Refund Policy',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

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
                color: isTotal ? AppColors.text : AppColors.mutedText,
                fontSize: 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: AppColors.text,
                fontSize: isTotal ? 16 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color iconBgColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.iconBgColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.buttonText, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.radio_button_checked_rounded, color: AppColors.primary, size: 20)
            else
              Icon(Icons.radio_button_off_rounded, color: AppColors.mutedText, size: 20),
          ],
        ),
      ),
    );
  }
}
