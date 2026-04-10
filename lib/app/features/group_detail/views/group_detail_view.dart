import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/group_detail_view_model.dart';

class GroupDetailView extends GetView<GroupDetailViewModel> {
  const GroupDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = (Get.arguments?['id'] ?? 1).toString();
    const performance = [
      {'month': 'Jan', 'profit': 12.0},
      {'month': 'Feb', 'profit': 18.0},
      {'month': 'Mar', 'profit': 15.0},
      {'month': 'Apr', 'profit': 22.0},
      {'month': 'May', 'profit': 28.0},
      {'month': 'Jun', 'profit': 32.0},
    ];
    const reviews = [
      {
        'user': 'Alex Smith',
        'avatar': '👤',
        'rating': 5,
        'comment':
            'Best trading group I\'ve ever joined. Signals are accurate and support is amazing!',
        'date': '2 days ago',
      },
      {
        'user': 'Emma Wilson',
        'avatar': '👩',
        'rating': 5,
        'comment':
            'Made back my investment in the first week. Highly recommended!',
        'date': '1 week ago',
      },
      {
        'user': 'Michael Brown',
        'avatar': '🧑',
        'rating': 4,
        'comment':
            'Great signals and community. Learning a lot from John\'s analysis.',
        'date': '2 weeks ago',
      },
    ];

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Group Details',),
        backgroundColor: AppColors.background,
        centerTitle: true,
        surfaceTintColor: AppColors.background,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: AppColors.text,
          ),
        ),
        actions: [
          Icon(Icons.share, size: 18, color: AppColors.text),
          SizedBox(width: 20),
        ],
      ),
        backgroundColor: AppColors.background,
      body: SafeArea(
        
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 110),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    MarketPanel(
                      radius: 18,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.accent,
                                    ],
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '🚀',
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Crypto Elite Signals',
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.verified,
                                          color: AppColors.primary,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    _CategoryTag(label: 'Crypto'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: const [
                              Expanded(
                                child: _StatTile(
                                  label: 'Rating',
                                  value: '4.9',
                                  icon: Icons.star,
                                  iconColor: Colors.amber,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _StatTile(
                                  label: 'ROI',
                                  value: '+127%',
                                  valueColor: Colors.green,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _StatTile(
                                  label: 'Win Rate',
                                  value: '78%',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Members',
                                    style: TextStyle(
                                      color: AppColors.mutedText,
                                    ),
                                  ),
                                  Text('850/1000'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.58,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.primary,
                                          AppColors.accent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          PrimaryButton(
                            label: 'Join Membership - \$99/mo',
                            onTap: () => Get.toNamed(
                              AppRoutes.payment,
                              arguments: {'groupId': id},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => Get.toNamed(
                        AppRoutes.traderProfile,
                        arguments: {'id': id},
                      ),
                      borderRadius: BorderRadius.circular(18),
                      child: MarketPanel(
                        radius: 18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About the Trader',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.accent,
                                        AppColors.primary,
                                      ],
                                    ),
                                  ),
                                  child: const Text(
                                    '👨‍💼',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'John Martinez',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.verified,
                                            color: AppColors.primary,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '8 years experience',
                                        style: TextStyle(
                                          color: AppColors.mutedText,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.12,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'View Profile',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Row(
                              children: [
                                Expanded(
                                  child: _SmallPanel(
                                    label: 'Total Members',
                                    value: '2500+',
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: _SmallPanel(
                                    label: 'Signals Sent',
                                    value: '450+',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    MarketPanel(
                      radius: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'About This Group',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Join our elite crypto trading community and receive high-quality trading signals with detailed analysis. Our proven track record speaks for itself.',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 10),
                          _FeatureRow(text: 'Real-time trading signals'),
                          _FeatureRow(text: '24/7 support'),
                          _FeatureRow(text: 'Risk management guidance'),
                          _FeatureRow(text: 'Market analysis reports'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    MarketPanel(
                      radius: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Performance (Last 6 Months)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 140,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: performance.map((p) {
                                final h = (p['profit']! as double) / 35;
                                return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 90 * h + 16,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                        ),
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              AppColors.primary,
                                              AppColors.accent,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        p['month']! as String,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.mutedText,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Expanded(
                                child: _SmallCenter(
                                  label: 'Total ROI',
                                  value: '+127%',
                                ),
                              ),
                              Expanded(
                                child: _SmallCenter(
                                  label: 'Win Rate',
                                  value: '78%',
                                ),
                              ),
                              Expanded(
                                child: _SmallCenter(
                                  label: 'Total Signals',
                                  value: '450',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    MarketPanel(
                      radius: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reviews (3)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(width: 2),
                                  Text('4.9'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...reviews.map(
                            (r) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: AppColors.border),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          colors: [
                                            AppColors.primary,
                                            AppColors.accent,
                                          ],
                                        ),
                                      ),
                                      child: Text(r['avatar']! as String),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                r['user']! as String,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                r['date']! as String,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors.mutedText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: List.generate(
                                              r['rating']! as int,
                                              (_) => const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 2,
                                                ),
                                                child: Icon(
                                                  Icons.star,
                                                  size: 12,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            r['comment']! as String,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.mutedText,
                                              height: 1.35,
                                            ),
                                          ),
                                        ],
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.card,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: PrimaryButton(
          label: 'Join Now - \$99/mo',
          onTap: () =>
              Get.toNamed(AppRoutes.payment, arguments: {'groupId': id}),
        ),
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  const _CategoryTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (icon != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: iconColor),
                const SizedBox(width: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            )
          else
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
          ),
        ],
      ),
    );
  }
}

class _SmallPanel extends StatelessWidget {
  const _SmallPanel({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.mutedText, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.16),
            ),
            child: const Center(
              child: CircleAvatar(
                radius: 3,
                backgroundColor: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12.5)),
        ],
      ),
    );
  }
}

class _SmallCenter extends StatelessWidget {
  const _SmallCenter({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
        ),
      ],
    );
  }
}
