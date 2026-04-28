import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/trader_subscription_view_model.dart';

class TraderSubscriptionView extends GetView<TraderSubscriptionViewModel> {
  const TraderSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SubscriptionBody();
  }
}

class _SubscriptionBody extends StatefulWidget {
  const _SubscriptionBody();

  @override
  State<_SubscriptionBody> createState() => _SubscriptionBodyState();
}

class _SubscriptionBodyState extends State<_SubscriptionBody> {
  String? selectedPlan;
  String billing = 'monthly';

  final plans = const [
    {
      'id': 'basic',
      'name': 'Basic',
      'monthly': '\$29',
      'yearly': '\$290',
      'groups': '1',
      'members': '500',
      'features': [
        'Create 1 Trading Group',
        'Up to 500 Members',
        'Basic Analytics',
        'Email Support',
        'Monthly Reports',
      ],
      'recommended': false,
      'icon': Icons.flash_on,
      'colors': [Color(0xFF34D399), Color(0xFF10B981)],
    },
    {
      'id': 'pro',
      'name': 'Pro',
      'monthly': '\$79',
      'yearly': '\$790',
      'groups': '3',
      'members': '2,000',
      'features': [
        'Create 3 Trading Groups',
        'Up to 2,000 Members',
        'Advanced Analytics',
        'Priority Support',
        'Weekly Reports',
        'Custom Branding',
        'API Access',
      ],
      'recommended': true,
      'icon': Icons.workspace_premium,
      'colors': [Color(0xFF059669), Color(0xFF34D399)],
    },
    {
      'id': 'premium',
      'name': 'Premium',
      'monthly': '\$199',
      'yearly': '\$1,990',
      'groups': 'Unlimited',
      'members': 'Unlimited',
      'features': [
        'Unlimited Trading Groups',
        'Unlimited Members',
        'Real-time Analytics',
        '24/7 Premium Support',
        'Daily Reports',
        'Full Customization',
        'API Access',
        'Dedicated Account Manager',
      ],
      'recommended': false,
      'icon': Icons.rocket_launch,
      'colors': [Color(0xFFF59E0B), Color(0xFFEAB308)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 130),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconSquare(icon: Icons.arrow_back, onTap: Get.back),
                    const Text(
                      'Choose Your Plan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 12),
                MarketPanel(
                  radius: 16,
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderColor: AppColors.primary.withValues(alpha: 0.2),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.shield, color: AppColors.primary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Your Trading Journey',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Choose a plan that fits your needs. Upgrade or downgrade anytime.',
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
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _toggle('monthly', 'Monthly')),
                      const SizedBox(width: 8),
                      Expanded(child: _toggle('yearly', 'Yearly')),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ...plans.map((p) {
                  final selected = selectedPlan == p['id'];
                  final price = billing == 'monthly'
                      ? p['monthly']
                      : p['yearly'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () =>
                          setState(() => selectedPlan = p['id']! as String),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.card,
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (p['recommended']! as bool)
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.accent,
                                      ],
                                    ),
                                  ),
                                  child: const Text(
                                    'Recommended',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      colors: p['colors']! as List<Color>,
                                    ),
                                  ),
                                  child: Icon(p['icon']! as IconData),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p['name']! as String,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'For ${(p['name']! as String).toLowerCase()} traders',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.mutedText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (selected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              price! as String,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '/${billing == 'monthly' ? 'month' : 'year'}',
                              style: const TextStyle(
                                color: AppColors.mutedText,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _limit(
                                    'Groups',
                                    p['groups']! as String,
                                    Icons.layers,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _limit(
                                    'Members',
                                    p['members']! as String,
                                    Icons.groups,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...(p['features']! as List<String>).map(
                              (f) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: p['colors']! as List<Color>,
                                        ),
                                      ),
                                      child: const Icon(Icons.check, size: 12),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        f,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            if (selectedPlan != null)
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
                        label:
                            'Subscribe to ${plans.firstWhere((p) => p['id'] == selectedPlan)['name']}',
                        icon: const Icon(Icons.trending_up, size: 16),
                        onTap: () {
                          final p = plans.firstWhere(
                            (x) => x['id'] == selectedPlan,
                          );
                          Get.toNamed(
                            AppRoutes.subscriptionPayment,
                            arguments: {
                              'plan': p['name'],
                              'price': billing == 'monthly'
                                  ? p['monthly']
                                  : p['yearly'],
                              'billing': billing,
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Cancel anytime • 30-day money back guarantee',
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

  Widget _toggle(String value, String label) {
    final active = billing == value;
    return InkWell(
      onTap: () => setState(() => billing = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                )
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : AppColors.mutedText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _limit(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.mutedText,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
