import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/trader_dashboard_view_model.dart';

class TraderDashboardView extends GetView<TraderDashboardViewModel> {
  const TraderDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const stats = [
      {
        'label': 'Total Members',
        'value': '1,270',
        'icon': Icons.groups,
        'colors': [Color(0xFF34D399), Color(0xFF10B981)],
      },
      {
        'label': 'Monthly Revenue',
        'value': '\$14,715',
        'icon': Icons.attach_money,
        'colors': [Color(0xFF059669), Color(0xFF10B981)],
      },
      {
        'label': 'Avg. ROI',
        'value': '+94%',
        'icon': Icons.trending_up,
        'colors': [Color(0xFF059669), Color(0xFF34D399)],
      },
      {
        'label': 'Success Rate',
        'value': '78%',
        'icon': Icons.bar_chart,
        'colors': [Color(0xFFF59E0B), Color(0xFFEAB308)],
      },
    ];

    const groups = [
      {
        'id': '1',
        'name': 'Crypto Elite Signals',
        'avatar': '🚀',
        'members': '850/1000',
        'revenue': '\$8,415',
        'growth': '+12%',
      },
      {
        'id': '2',
        'name': 'Advanced Crypto Pro',
        'avatar': '💎',
        'members': '420/500',
        'revenue': '\$6,300',
        'growth': '+8%',
      },
    ];

    const activity = [
      {
        'title': 'New member joined',
        'group': 'Crypto Elite Signals',
        'time': '2 hours ago',
        'icon': Icons.person_add,
      },
      {
        'title': 'Signal sent',
        'group': 'Advanced Crypto Pro',
        'time': '4 hours ago',
        'icon': Icons.trending_up,
      },
      {
        'title': 'Subscription renewed',
        'group': 'Crypto Elite Signals',
        'time': '1 day ago',
        'icon': Icons.attach_money,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const MarketBottomNav(currentIndex: 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 90),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.traderAccount),
                  child: Row(
                    children: [
                      _Avatar(),
                      SizedBox(width: 10),
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
                            'John Martinez',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      //   onTap: () => Get.offNamed(AppRoutes.chats),
                      child: Icon(
                        Icons.notifications_none,
                        size: 20,
                        color: AppColors.mutedText,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      //  onTap: () => Get.offNamed(AppRoutes.chats),
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
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                          gradient: LinearGradient(
                            colors: s['colors']! as List<Color>,
                          ),
                        ),
                        child: Icon(s['icon']! as IconData),
                      ),
                      const Spacer(),
                      Text(
                        s['value']! as String,
                        style: TextStyle(
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
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.traderAccount),
              child: MarketPanel(
                radius: 16,
                color: AppColors.card,
                child: Row(
                  children: [
                    _Crown(),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pro Plan Active',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '2 of 3 groups • 1,270 of 2,000 members',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '26 days left',
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
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Create Group',
                    icon: Icon(Icons.add, size: 16),
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
                      child: Row(
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
                Text(
                  'My Trading Groups',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.createGroup),
                  child: Text(
                    '+ New Group',
                    style: TextStyle(color: AppColors.accent, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...groups.map(
              (g) => Padding(
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
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.accent],
                              ),
                            ),
                            child: Text(
                              g['avatar']! as String,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  g['name']! as String,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  g['members']! as String,
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
                              arguments: {'groupId': g['id']},
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.accent],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.message, size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    'Manage',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
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
                              g['revenue']! as String,
                              'Monthly Revenue',
                              true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _tile(
                              g['growth']! as String,
                              'Growth Rate',
                              false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.traderInbox),
                  child: Text(
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
                              style: TextStyle(
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
  const _Avatar();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
      ),
      child: Text('👨‍💼', style: TextStyle(fontSize: 24)),
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
