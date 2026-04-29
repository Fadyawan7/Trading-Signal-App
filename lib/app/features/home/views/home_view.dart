import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../../../widgets/market_ui.dart';
import '../../../widgets/market_widgets.dart';
import '../viewmodel/home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = const [
      {'name': 'Crypto', 'icon': '💰'},
      {'name': 'Forex', 'icon': '💵'},
      {'name': 'Gold', 'icon': '🏆'},
      {'name': 'Stocks', 'icon': '📊'},
    ];

    final topGroups = const [
      {
        'name': 'Crypto Elite Signals',
        'trader': 'John Martinez',
        'members': '850/1000',
        'roi': '+127%',
        'rating': '4.9',
        'price': '\$99/mo',
        'avatar': '🚀',
      },
      {
        'name': 'Forex Masters Club',
        'trader': 'Sarah Chen',
        'members': '720/800',
        'roi': '+94%',
        'rating': '4.8',
        'price': '\$149/mo',
        'avatar': '💎',
      },
      {
        'name': 'Gold Trading Pro',
        'trader': 'Mike Johnson',
        'members': '450/500',
        'roi': '+68%',
        'rating': '4.7',
        'price': 'Free',
        'avatar': '⚡',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const MarketBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Alex Smith',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: 42,
                          height: 42,

                          child: Icon(Icons.notifications_none_rounded),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // InkWell(
                    //   onTap: () => Get.toNamed(AppRoutes.profile),
                    //   child: Container(
                    //     width: 30,
                    //     height: 30,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(7),
                    //       gradient: const LinearGradient(
                    //         colors: [AppColors.primary, AppColors.accent],
                    //       ),
                    //     ),
                    //     child: Center(child: Text('👤')),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search trading groups...',
                  prefixIcon: Icon(Icons.search_rounded),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Join Trusted Trading Groups',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Connect with verified traders and receive real-time signals',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            label: 'Explore Groups',
                            onTap: () => Get.toNamed(AppRoutes.explore),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SecondaryButton(
                            label: 'Become Trader',
                            onTap: () => Get.toNamed(AppRoutes.applyTrader),
                            textColor: Colors.white,
                            borderColor: Colors.white38,
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              c['icon']!,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          c['name']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Top Trading Groups',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(height: 10),
              ...topGroups.map((group) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MarketCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.accent],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  group['avatar']!,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    group['name']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'by ${group['trader']}',
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
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _MiniStat(
                                title: 'Members',
                                value: group['members']!,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _MiniStat(
                                title: 'ROI',
                                value: group['roi']!,
                                green: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _MiniStat(
                                title: 'Rating',
                                value: group['rating']!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              group['price']!,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.accent],
                                ),
                              ),
                              child: Text(
                                'Join Now',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.title,
    required this.value,
    this.green = false,
  });

  final String title;
  final String value;
  final bool green;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: green ? const Color(0x1A10B981) : AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors.mutedText, fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: green ? AppColors.primary : AppColors.text,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
