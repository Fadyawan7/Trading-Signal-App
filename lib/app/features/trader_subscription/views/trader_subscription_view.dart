import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_loading_overlay.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../viewmodel/trader_subscription_view_model.dart';
import '../../apply_trader/data/models/subscription_plan.dart';

class TraderSubscriptionView extends GetView<TraderSubscriptionViewModel> {
  const TraderSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        message: 'Loading plans...',
        child: Scaffold(
          backgroundColor: AppColors.background,
          extendBody: true,
          bottomNavigationBar: const MarketBottomNav(currentIndex: 0),
          body: Stack(
            children: [
              // Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.backgroundSecondary,
                        AppColors.background,
                      ],
                    ),
                  ),
                ),
              ),
              const _SubscriptionBody(),
            ],
          ),
        ),
      ),
    );
  }
}


class _SubscriptionBody extends GetView<TraderSubscriptionViewModel> {
  const _SubscriptionBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const _Header(),
          Expanded(
            child: Obx(() {
              final activeCycle = controller.billingCycle.value;
              final list = controller.plans;

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                children: [
                  const _IntroCard(),
                  const SizedBox(height: 24),
                  _BillingToggle(
                    current: activeCycle,
                    onChanged: (v) => controller.setBillingCycle(v),
                  ),
                  const SizedBox(height: 24),
                  
                  if (list.isEmpty && !controller.isLoading.value)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(Icons.layers_clear_outlined, color: AppColors.mutedText, size: 48),
                            const SizedBox(height: 16),
                            Text(
                              'No subscription plans available for this tier.',
                              style: TextStyle(color: AppColors.mutedText, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...list.map((plan) {
                      final isSelected = controller.selectedPlanId.value == plan.id;
                      return _PlanCard(
                        plan: plan,
                        billing: activeCycle,
                        isSelected: isSelected,
                        onSelect: () => controller.selectedPlanId.value = plan.id,
                      );
                    }),
                  const SizedBox(height: 30),
                ],
              );
            }),
          ),
          Obx(() {
            final selId = controller.selectedPlanId.value;
            if (selId == null || controller.plans.isEmpty) {
              return const SizedBox.shrink();
            }
            final selectedPlan = controller.plans.firstWhereOrNull((p) => p.id == selId);
            if (selectedPlan == null) return const SizedBox.shrink();

            return _BottomAction(
              planName: selectedPlan.name,
              onTap: () => controller.buySubscriptionPlan(selectedPlan.id),
            );
          }),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

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
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF14B8A6).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF14B8A6).withValues(alpha: 0.1)),
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
          Expanded(child: _toggleItem('weekly', 'Weekly')),
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
  final SubscriptionPlan plan;
  final String billing;
  final bool isSelected;
  final VoidCallback onSelect;

  const _PlanCard({required this.plan, required this.billing, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isPremium = plan.price >= 100.0;
    final isRecommended = plan.name.toLowerCase().contains('pro') || plan.name.toLowerCase().contains('test 1');
    final Color color = isPremium ? const Color(0xFFF59E0B) : const Color(0xFF14B8A6);

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
                        child: plan.icon.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  plan.icon,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    isPremium ? Icons.rocket_launch_rounded : Icons.workspace_premium_rounded,
                                    color: color,
                                    size: 28,
                                  ),
                                ),
                              )
                            : Icon(
                                isPremium ? Icons.rocket_launch_rounded : Icons.workspace_premium_rounded,
                                color: color,
                                size: 28,
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.name,
                              style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'For ${plan.name.toLowerCase()} traders',
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
                        '\$${plan.price.toStringAsFixed(0)}',
                        style: TextStyle(color: AppColors.text, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '/$billing',
                          style: TextStyle(color: AppColors.mutedText, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          label: 'Groups Limit',
                          value: plan.is_unlimited_groups ? 'Unlimited' : plan.allow_groups.toString(),
                          icon: Icons.layers_outlined,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatBox(
                          label: 'Members Limit',
                          value: plan.is_unlimited_members ? 'Unlimited' : plan.allow_members.toString(),
                          icon: Icons.people_outline_rounded,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (plan.description.isNotEmpty)
                    ...plan.description.map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: color, size: 18),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              f,
                              style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
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
