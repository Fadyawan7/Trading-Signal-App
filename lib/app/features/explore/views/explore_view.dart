import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
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
    final groups = [
      {
        'id': 1,
        'name': 'Crypto Elite Signals',
        'trader': 'John Martinez',
        'members': '850/1000',
        'roi': '+127%',
        'rating': '4.9',
        'price': '\$99/mo',
        'category': 'Crypto',
        'icon': Icons.currency_bitcoin,
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
        'icon': Icons.attach_money,
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
        'icon': Icons.monetization_on,
      },
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        bottomNavigationBar: const MarketBottomNav(currentIndex: 1),
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
              child: Column(
                children: [
                  const _Header(),
                  const SizedBox(height: 12),
                  const _SearchBar(),
                  const SizedBox(height: 12),
                  _FiltersList(filters: filters),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        final g = groups[index];
                        return _GroupCard(
                          name: g['name'] as String,
                          trader: g['trader'] as String,
                          members: g['members'] as String,
                          roi: g['roi'] as String,
                          rating: g['rating'] as String,
                          price: g['price'] as String,
                          category: g['category'] as String,
                          icon: g['icon'] as IconData,
                        );
                      },
                    ),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          'Explore Groups',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.mutedText, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                style: TextStyle(color: AppColors.text, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Search groups by name or tr',
                  hintStyle: TextStyle(color: AppColors.mutedText),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Icon(Icons.filter_list_rounded, color: AppColors.mutedText, size: 18),
          ],
        ),
      ),
    );
  }
}

class _FiltersList extends StatelessWidget {
  final List<String> filters;

  const _FiltersList({required this.filters});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: filters.map((f) => _FilterChip(label: f, isActive: f == 'All')).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: isActive ? null : Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.buttonText : AppColors.text,
          fontSize: 13,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final String name;
  final String trader;
  final String members;
  final String roi;
  final String rating;
  final String price;
  final String category;
  final IconData icon;

  const _GroupCard({
    required this.name,
    required this.trader,
    required this.members,
    required this.roi,
    required this.rating,
    required this.price,
    required this.category,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.groupDetail),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: Icon(icon, color: AppColors.text, size: 20),
                  ),
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
                          overflow: TextOverflow.ellipsis,
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
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
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
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 13),
                      const SizedBox(width: 2),
                      Text(
                        rating,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    roi,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _InfoBox(label: 'Members', value: members),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _InfoBox(label: 'Price', value: price, isPrice: true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.groupDetail),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: AppColors.buttonText,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final bool isPrice;

  const _InfoBox({required this.label, required this.value, this.isPrice = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: isPrice ? AppColors.primary : AppColors.text,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
