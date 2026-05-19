import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/trader_dashboard_view_model.dart';

class TraderDashboardView extends GetView<TraderDashboardViewModel> {
  const TraderDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const activity = [
      {
        'title': 'New member joined',
        'group': 'Gold Trading Group',
        'time': '2 hours ago',
        'icon': Icons.person_add,
      },
      {
        'title': 'Signal sent',
        'group': 'Gold Trading Group',
        'time': '4 hours ago',
        'icon': Icons.trending_up,
      },
      {
        'title': 'Subscription renewed',
        'group': 'Gold Trading Group',
        'time': '1 day ago',
        'icon': Icons.attach_money,
      },
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      bottomNavigationBar: const MarketBottomNav(currentIndex: 0),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.card,
          onRefresh: () => controller.fetchDashboardData(),
          child: Obx(() {
            final data = controller.rxDashboardData.value;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            final user = data.user;
            final statsInfo = data.stats;
            final subInfo = data.subscription;
            final groupList = data.groups;

            final stats = [
              {
                'label': 'Total Members',
                'value': statsInfo.totalMembers.toString(),
                'icon': Icons.groups,
              },
              {
                'label': 'Monthly Revenue',
                'value': '\$${statsInfo.monthlyRevenue}',
                'icon': Icons.attach_money,
              },
              {
                'label': 'Total Signals',
                'value': statsInfo.totalSignals.toString(),
                'icon': Icons.trending_up,
              },
              {
                'label': 'Success Rate',
                'value': '${statsInfo.successRate}%',
                'icon': Icons.bar_chart,
              },
            ];

            final session = Get.find<SessionService>();
            final sessionUser = session.currentUser.value;
            final avatarUrl = sessionUser?.profileImage ?? sessionUser?.avatar ?? user.profileImage ?? user.avatar;

            return ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 90),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed(AppRoutes.traderAccount),
                      child: Row(
                        children: [
                          _Avatar(avatarUrl: avatarUrl),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trader Dashboard',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.mutedText,
                                ),
                              ),
                              Text(
                                user.name.isNotEmpty ? user.name : 'Trader',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.notifications_none,
                            size: 20,
                            color: AppColors.mutedText,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: Icon(
                            Icons.settings,
                            size: 20,
                            color: AppColors.mutedText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: stats.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (_, i) {
                    final s = stats[i];
                    return MarketPanel(
                      radius: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.primary.withValues(alpha: 0.15),
                            ),
                            child: Icon(s['icon']! as IconData, color: AppColors.primary),
                          ),
                          const Spacer(),
                          Text(
                            s['value']! as String,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            s['label']! as String,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.mutedText,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                if (subInfo != null) ...[
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.traderAccount),
                    child: MarketPanel(
                      radius: 16,
                      color: AppColors.card,
                      child: Row(
                        children: [
                          const _Crown(),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${subInfo.planName} Plan Active',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  subInfo.isUnlimitedGroups 
                                    ? '${subInfo.activeGroups} groups • ${subInfo.totalMembers} of ${subInfo.isUnlimitedMembers ? 'Unlimited' : subInfo.membersLimit} members'
                                    : '${subInfo.activeGroups} of ${subInfo.totalGroupsLimit} groups • ${subInfo.totalMembers} of ${subInfo.isUnlimitedMembers ? 'Unlimited' : subInfo.membersLimit} members',
                                  style: TextStyle(
                                    color: AppColors.mutedText,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${subInfo.daysLeft} days left',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Create Group',
                        icon: const Icon(Icons.add, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.createGroup),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: MarketPanel(
                          radius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bar_chart, color: AppColors.primary),
                              SizedBox(width: 6),
                              Text(
                                'Analytics',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Trading Groups',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(AppRoutes.createGroup),
                      child: const Text(
                        '+ New Group',
                        style: TextStyle(color: AppColors.accent, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (groupList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No trading groups created yet.',
                        style: TextStyle(color: AppColors.mutedText, fontSize: 13),
                      ),
                    ),
                  )
                else
                  ...groupList.map(
                    (g) {
                      final double growthRate = (g.growthRate is num) ? (g.growthRate as num).toDouble() : 0.0;
                      final growthText = growthRate >= 0 ? '+${growthRate.toStringAsFixed(0)}%' : '${growthRate.toStringAsFixed(0)}%';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MarketPanel(
                          radius: 16,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.primary.withValues(alpha: 0.15),
                                      border: Border.all(color: AppColors.border),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: g.groupIcon != null && g.groupIcon!.isNotEmpty
                                          ? Image.network(
                                              g.groupIcon!,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) => const Icon(
                                                Icons.group,
                                                size: 24,
                                                color: AppColors.primary,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.group,
                                              size: 24,
                                              color: AppColors.primary,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          g.name,
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${g.members} members (Limit: ${g.limit})',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.mutedText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                      AppRoutes.groupChat,
                                      arguments: {'groupId': g.id.toString()},
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primary.withValues(alpha: 0.15),
                                      ),
                                      child: const Icon(
                                        Icons.message,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () => controller.showDeleteGroupDialog(context, g.id),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red.withValues(alpha: 0.15),
                                      ),
                                      child: const Icon(
                                        Icons.delete_outline_rounded,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _tile(
                                      '\$${g.monthlyRevenue}',
                                      'Monthly Revenue',
                                      true,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _tile(
                                      growthText,
                                      'Growth Rate',
                                      growthRate >= 0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Activity',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(AppRoutes.traderInbox),
                      child: const Text(
                        'View All →',
                        style: TextStyle(color: AppColors.accent, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...activity.map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: MarketPanel(
                      radius: 14,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.accent],
                              ),
                            ),
                            child: Icon(a['icon']! as IconData, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  a['title']! as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  a['group']! as String,
                                  style: TextStyle(
                                    color: AppColors.mutedText,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            a['time']! as String,
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _tile(String value, String label, bool green) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: green
            ? Colors.green.withValues(alpha: 0.10)
            : AppColors.primary.withValues(alpha: 0.10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: green ? Colors.green : AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.mutedText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? avatarUrl;
  const _Avatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    final bool isUrl = avatarUrl != null &&
        (avatarUrl!.startsWith('http://') || avatarUrl!.startsWith('https://') || avatarUrl!.contains('/'));

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.primary.withValues(alpha: 0.15),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Center(
          child: avatarUrl != null && avatarUrl!.isNotEmpty
              ? (isUrl
                  ? Image.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 20, color: AppColors.primary),
                    )
                  : Text(
                      avatarUrl!,
                      style: const TextStyle(fontSize: 22),
                    ))
              : const Icon(Icons.person, size: 20, color: AppColors.primary),
        ),
      ),
    );
  }
}

class _Crown extends StatelessWidget {
  const _Crown();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF059669), Color(0xFF34D399)],
        ),
      ),
      child: Icon(Icons.workspace_premium),
    );
  }
}
