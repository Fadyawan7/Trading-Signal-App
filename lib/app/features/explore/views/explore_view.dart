import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/explore_view_model.dart';

class ExploreView extends GetView<ExploreViewModel> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    const filters = [
      'All',
      'Free',
      'Paid',
      'Crypto',
      'Forex',
      'Gold',
      'Stocks',
    ];
    const groups = [
      {
        'id': 1,
        'name': 'Crypto Elite Signals',
        'trader': 'John Martinez',
        'members': '850/1000',
        'roi': '+127%',
        'rating': '4.9',
        'price': '\$99/mo',
        'category': 'Crypto',
        'avatar': '🚀',
      },
      {
        'id': 2,
        'name': 'Forex Masters Club',
        'trader': 'Sarah Chen',
        'members': '720/800',
        'roi': '+94%',
        'rating': '4.8',
        'price': '\$149/mo',
        'category': 'Forex',
        'avatar': '💎',
      },
      {
        'id': 3,
        'name': 'Gold Trading Pro',
        'trader': 'Mike Johnson',
        'members': '450/500',
        'roi': '+68%',
        'rating': '4.7',
        'price': 'Free',
        'category': 'Gold',
        'avatar': '⚡',
      },
      {
        'id': 4,
        'name': 'Stock Market Wizards',
        'trader': 'David Brown',
        'members': '620/700',
        'roi': '+85%',
        'rating': '4.6',
        'price': '\$79/mo',
        'category': 'Stocks',
        'avatar': '📊',
      },
      {
        'id': 5,
        'name': 'Crypto Moonshots',
        'trader': 'Lisa Wang',
        'members': '380/500',
        'roi': '+156%',
        'rating': '4.8',
        'price': '\$199/mo',
        'category': 'Crypto',
        'avatar': '🌙',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const MarketBottomNav(currentIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                children: [
                   const Text(
                        'Explore Groups',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search groups by name or trader...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            ),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filters
                          .map(
                            (f) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChipPill(label: f, active: f == 'All'),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
                itemCount: groups.length,
                itemBuilder: (_, i) {
                  final g = groups[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        AppRoutes.groupDetail,
                        arguments: {'id': g['id']},
                      ),
                      borderRadius: BorderRadius.circular(18),
                      child: MarketPanel(
                        radius: 18,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.accent,
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    g['avatar']! as String,
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              g['name']! as String,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.verified,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'by ${g['trader']}',
                                        style: const TextStyle(
                                          color: AppColors.mutedText,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.12,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                        child: Text(
                                          g['category']! as String,
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          g['rating']! as String,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      g['roi']! as String,
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: AppColors.border),
                            Row(
                              children: [
                                Expanded(
                                  child: _InfoCell(
                                    label: 'Members',
                                    value: g['members']! as String,
                                  ),
                                ),
                                Expanded(
                                  child: _InfoCell(
                                    label: 'Price',
                                    value: g['price']! as String,
                                    primary: true,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.accent,
                                      ],
                                    ),
                                  ),
                                  child: const Text(
                                    'View Details',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({
    required this.label,
    required this.value,
    this.primary = false,
  });

  final String label;
  final String value;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primary ? AppColors.primary : Colors.white,
          ),
        ),
      ],
    );
  }
}
