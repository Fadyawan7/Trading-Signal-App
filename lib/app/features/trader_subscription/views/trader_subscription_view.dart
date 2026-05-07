import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
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

  final List<Map<String, dynamic>> plans = [
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
      'isPremium': false,
      'icon': Icons.bolt_rounded,
      'color': const Color(0xFF14B8A6),
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
      'isPremium': false,
      'icon': Icons.workspace_premium_rounded,
      'color': const Color(0xFF14B8A6),
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
        'Early Access to Features',
      ],
      'recommended': false,
      'isPremium': true,
      'icon': Icons.rocket_launch_rounded,
      'color': const Color(0xFFF59E0B),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bgColor = AppColors.background;
      return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(
            children: [
              _Header(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  children: [
                    _IntroCard(),
                    const SizedBox(height: 24),
                    _BillingToggle(
                      current: billing,
                      onChanged: (v) => setState(() => billing = v),
                    ),
                    const SizedBox(height: 24),
                    ...plans.map((p) => _PlanCard(
                          plan: p,
                          billing: billing,
                          isSelected: selectedPlan == p['id'],
                          onSelect: () => setState(() => selectedPlan = p['id'] as String),
                        )),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              if (selectedPlan != null) _BottomAction(
                planName: plans.firstWhere((p) => p['id'] == selectedPlan)['name'] as String,
                onTap: () {
                  final p = plans.firstWhere((x) => x['id'] == selectedPlan);
                  Get.toNamed(AppRoutes.subscriptionPayment, arguments: {
                    'plan': p['name'],
                    'price': billing == 'monthly' ? p['monthly'] : p['yearly'],
                    'billing': billing,
                  });
                },
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
            'Choose Your Plan',
            style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF14B8A6).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF14B8A6).withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: Color(0xFF14B8A6), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Your Trading Journey',
                  style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose a plan that fits your needs. Upgrade or downgrade anytime.',
                  style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BillingToggle extends StatelessWidget {
  final String current;
  final Function(String) onChanged;

  const _BillingToggle({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(child: _toggleItem('monthly', 'Monthly')),
          Expanded(child: _toggleItem('yearly', 'Yearly', badge: 'Save 20%')),
        ],
      ),
    );
  }

  Widget _toggleItem(String id, String label, {String? badge}) {
    final active = current == id;
    return InkWell(
      onTap: () => onChanged(id),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: active ? const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF0D9488)]) : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: active ? Colors.white : AppColors.mutedText, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            if (badge != null)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: active ? Colors.white.withOpacity(0.2) : const Color(0xFF14B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(color: active ? Colors.white : const Color(0xFF14B8A6), fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final String billing;
  final bool isSelected;
  final VoidCallback onSelect;

  const _PlanCard({required this.plan, required this.billing, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isPremium = plan['isPremium'] == true;
    final isRecommended = plan['recommended'] == true;
    final Color color = plan['color'] as Color? ?? const Color(0xFF14B8A6);
    final price = billing == 'monthly' ? plan['monthly'] : plan['yearly'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onSelect,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isPremium ? color.withOpacity(0.05) : AppColors.card,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? color : (isPremium ? color.withOpacity(0.3) : AppColors.border),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(plan['icon'] as IconData? ?? Icons.star_rounded, color: color, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan['name']?.toString() ?? 'Plan',
                              style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'For ${plan['name']?.toString().toLowerCase() ?? ""} traders',
                              style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected) Icon(Icons.check_circle_rounded, color: color, size: 28),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price?.toString() ?? '\$0',
                        style: TextStyle(color: AppColors.text, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '/${billing == 'monthly' ? 'month' : 'year'}',
                          style: TextStyle(color: AppColors.mutedText, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _StatBox(label: 'Groups', value: plan['groups']?.toString() ?? '0', icon: Icons.layers_outlined, color: color)),
                      const SizedBox(width: 12),
                      Expanded(child: _StatBox(label: 'Members', value: plan['members']?.toString() ?? '0', icon: Icons.people_outline_rounded, color: color)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (plan['features'] != null)
                    ...(plan['features'] as List<String>).map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: color, size: 18),
                          const SizedBox(width: 12),
                          Expanded(child: Text(f, style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500))),
                        ],
                      ),
                    )),
                ],
              ),
            ),
          ),
          if (isRecommended)
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14B8A6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Recommended', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          if (isPremium)
            Positioned(
              top: -12,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text('Premium', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;

  const _StatBox({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final String planName;
  final VoidCallback onTap;

  const _BottomAction({required this.planName, required this.onTap});

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
                gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF0D9488)]),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF10B981).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: Center(
                child: Text('Subscribe to $planName', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text('Cancel anytime • 30-day money back guarantee', style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
        ],
      ),
    );
  }
}
