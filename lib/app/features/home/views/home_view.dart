import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../viewmodel/home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        bottomNavigationBar: const MarketBottomNav(currentIndex: 0),
        body: Stack(
          children: [
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
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Header(),
                    const SizedBox(height: 16),
                    const _SearchBar(),
                    const SizedBox(height: 20),
                    const _FeaturedCard(),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Categories'),
                    const SizedBox(height: 12),
                    const _CategoriesGrid(),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Top Trading Groups'),
                    const SizedBox(height: 12),
                    const _TradingGroupsList(),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Verified Traders'),
                    const SizedBox(height: 12),
                    const _VerifiedTradersList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
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
              const SizedBox(height: 2),
              Text(
                'Alex Smith',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const _HeaderIcon(
          icon: Icons.notifications_none_rounded,
          hasNotification: true,
        ),
        const SizedBox(width: 12),
        const _HeaderIcon(icon: Icons.people_outline_rounded),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final bool hasNotification;

  const _HeaderIcon({required this.icon, this.hasNotification = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (icon == Icons.people_outline_rounded) {
          Get.toNamed(AppRoutes.profile);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: AppColors.text, size: 20),
            if (hasNotification)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.card, width: 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.explore),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.mutedText, size: 18),
            const SizedBox(width: 10),
            Text(
              'Search trading groups...',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.explore),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF14B8A6),
              Color(0xFF0D9488),
            ],
          ),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  'FEATURED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Join Trusted Trading Groups',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Connect with verified traders and receive real-time signals',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.toNamed('/explore'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Explore Groups',
                            style: TextStyle(
                              color: Color(0xFF14B8A6),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Color(0xFF14B8A6), size: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => Get.toNamed('/apply-trader'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                    ),
                    child: const Center(
                      child: Text(
                        'Become a Trader',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.explore),
          child: const Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF14B8A6),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: Color(0xFF14B8A6), size: 12),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid();

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Crypto', 'icon': Icons.currency_bitcoin},
      {'name': 'Forex', 'icon': Icons.attach_money},
      {'name': 'Gold', 'icon': Icons.monetization_on},
      {'name': 'Stocks', 'icon': Icons.show_chart},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((c) => _CategoryItem(
        name: c['name'] as String,
        icon: c['icon'] as IconData,
      )).toList(),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const _CategoryItem({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/explore', arguments: {'category': name}),
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TradingGroupsList extends StatelessWidget {
  const _TradingGroupsList();

  @override
  Widget build(BuildContext context) {
    final groups = [
      {
        'name': 'Crypto Elite Signals',
        'trader': 'John Martinez',
        'members': '850/1000',
        'roi': '+127%',
        'rating': '4.9',
        'price': '\$99/mo',
        'icon': Icons.currency_bitcoin,
      },
      {
        'name': 'Forex Masters Club',
        'trader': 'Sarah Chen',
        'members': '720/800',
        'roi': '+94%',
        'rating': '4.8',
        'price': '\$149/mo',
        'icon': Icons.attach_money,
      },
      {
        'name': 'Gold Trading Pro',
        'trader': 'Mike Johnson',
        'members': '450/500',
        'roi': '+68%',
        'rating': '4.7',
        'price': 'Free',
        'icon': Icons.monetization_on,
      },
    ];

    return Column(
      children: groups.map((g) => _TradingGroupCard(
        name: g['name'] as String,
        trader: g['trader'] as String,
        members: g['members'] as String,
        roi: g['roi'] as String,
        rating: g['rating'] as String,
        price: g['price'] as String,
        icon: g['icon'] as IconData,
      )).toList(),
    );
  }
}

class _TradingGroupCard extends StatelessWidget {
  final String name;
  final String trader;
  final String members;
  final String roi;
  final String rating;
  final String price;
  final IconData icon;

  const _TradingGroupCard({
    required this.name,
    required this.trader,
    required this.members,
    required this.roi,
    required this.rating,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.groupDetail, arguments: {'name': name}),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(icon, color: AppColors.text, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: Color(0xFF14B8A6), size: 12),
                        ],
                      ),
                      Text(
                        'by $trader',
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
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _StatBox(label: 'Members', value: members)),
                const SizedBox(width: 6),
                Expanded(child: _StatBox(label: 'ROI', value: roi, isGreen: true)),
                const SizedBox(width: 6),
                Expanded(child: _StatBox(label: 'Rating', value: rating, hasStar: true)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {}, // TODO: Implement Join Now
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Join Now',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final bool isGreen;
  final bool hasStar;

  const _StatBox({
    required this.label,
    required this.value,
    this.isGreen = false,
    this.hasStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasStar)
                const Icon(Icons.star, color: Colors.amber, size: 12),
              if (hasStar) const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  color: isGreen ? AppColors.primary : AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerifiedTradersList extends StatelessWidget {
  const _VerifiedTradersList();

  @override
  Widget build(BuildContext context) {
    final traders = [
      {'name': 'Alex Turner', 'category': 'Crypto', 'rating': '4.9', 'roi': '+145%', 'initials': 'AT'},
      {'name': 'Emma Davis', 'category': 'Forex', 'rating': '4.8', 'roi': '+112%', 'initials': 'ED'},
      {'name': 'Chris Lee', 'category': 'Stocks', 'rating': '4.7', 'roi': '+89%', 'initials': 'CL'},
    ];

    return Column(
      children: traders.map((t) => _TraderCard(
        name: t['name']!,
        category: t['category']!,
        rating: t['rating']!,
        roi: t['roi']!,
        initials: t['initials']!,
      )).toList(),
    );
  }
}

class _TraderCard extends StatelessWidget {
  final String name;
  final String category;
  final String rating;
  final String roi;
  final String initials;

  const _TraderCard({
    required this.name,
    required this.category,
    required this.rating,
    required this.roi,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.traderProfile, arguments: {'name': name}),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, color: Color(0xFF14B8A6), size: 14),
                  ],
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                roi,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    ),
  ),
);
}
}
