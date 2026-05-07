import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/group_detail_view_model.dart';

class GroupDetailView extends GetView<GroupDetailViewModel> {
  const GroupDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = (Get.arguments?['id'] ?? 1).toString();
    
    return Obx(() {
      // Trigger listener
      AppColors.background; 

      return Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.5),
                      AppColors.background,
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _Header(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      child: Column(
                        children: [
                          _MainGroupCard(id: id),
                          const SizedBox(height: 20),
                          _TraderSection(),
                          const SizedBox(height: 20),
                          _AboutGroupSection(),
                          const SizedBox(height: 20),
                          _PerformanceSection(),
                          const SizedBox(height: 20),
                          _ReviewsSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background.withValues(alpha: 0),
                      AppColors.background,
                    ],
                  ),
                ),
                child: InkWell(
                  onTap: () => Get.toNamed(AppRoutes.payment, arguments: {'groupId': id}),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Join Now - \$99/mo',
                        style: TextStyle(
                          color: AppColors.buttonText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HeaderButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Get.back(),
          ),
          _HeaderButton(
            icon: Icons.share_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.text.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.text, size: 16),
      ),
    );
  }
}

class _MainGroupCard extends StatelessWidget {
  final String id;
  const _MainGroupCard({required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Center(
                  child: Text('🚀', style: TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Crypto Elite Signals',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.verified, color: AppColors.mutedText, size: 14),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: const Text(
                        'Crypto',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(child: _StatBox(label: 'Rating', value: '4.9', icon: Icons.star, iconColor: Colors.amber)),
              const SizedBox(width: 8),
              const Expanded(child: _StatBox(label: 'ROI', value: '+127%', isHighlight: true)),
              const SizedBox(width: 8),
              const Expanded(child: _StatBox(label: 'Win Rate', value: '78%')),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Members',
                    style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                  ),
                  Text(
                    '850/1000',
                    style: TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 85,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const Expanded(flex: 15, child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => Get.toNamed(AppRoutes.payment, arguments: {'groupId': id}),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  'Join Membership - \$99/mo',
                  style: TextStyle(
                    color: AppColors.buttonText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final bool isHighlight;

  const _StatBox({
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHighlight ? AppColors.primary.withValues(alpha: 0.3) : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor, size: 12),
                const SizedBox(width: 3),
              ],
              Text(
                value,
                style: TextStyle(
                  color: isHighlight ? AppColors.primary : AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(color: AppColors.mutedText, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _TraderSection extends StatelessWidget {
  const _TraderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the Trader',
            style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Center(child: Text('👨‍💼', style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'John Martinez',
                          style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 3),
                        Icon(Icons.verified, color: AppColors.primary.withValues(alpha: 0.5), size: 12),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '8 years experience',
                      style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: const Text(
                    'View Profile',
                    style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: _TraderMetric(label: 'Total Members', value: '2500+')),
              const SizedBox(width: 10),
              const Expanded(child: _TraderMetric(label: 'Signals Sent', value: '450+')),
            ],
          ),
        ],
      ),
    );
  }
}

class _TraderMetric extends StatelessWidget {
  final String label;
  final String value;

  const _TraderMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 10)),
        ],
      ),
    );
  }
}

class _AboutGroupSection extends StatelessWidget {
  const _AboutGroupSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This Group',
            style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Join our elite crypto trading community and receive high-quality trading signals with detailed analysis. Our proven track record speaks for itself.',
            style: TextStyle(color: AppColors.mutedText, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 16),
          const _FeatureItem(icon: Icons.bolt_rounded, label: 'Real-time trading signals'),
          const _FeatureItem(icon: Icons.notifications_none_rounded, label: '24/7 support'),
          const _FeatureItem(icon: Icons.lock_outline_rounded, label: 'Risk management guidance'),
          const _FeatureItem(icon: Icons.analytics_outlined, label: 'Market analysis reports'),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: AppColors.primary, size: 14),
          ),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(color: AppColors.text, fontSize: 13)),
        ],
      ),
    );
  }
}

class _PerformanceSection extends StatelessWidget {
  const _PerformanceSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance (Last 6 Months)',
            style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'].map((m) {
              return Text(m, style: TextStyle(color: AppColors.mutedText, fontSize: 10));
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: _PerfCard(label: 'Total ROI', value: '+127%', color: AppColors.primary)),
              const SizedBox(width: 8),
              const Expanded(child: _PerfCard(label: 'Win Rate', value: '78%')),
              const SizedBox(width: 8),
              const Expanded(child: _PerfCard(label: 'Total Signals', value: '450')),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerfCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _PerfCard({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color != null ? color!.withValues(alpha: 0.3) : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color ?? AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(color: AppColors.mutedText, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews (5)',
                style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    SizedBox(width: 4),
                    Text(
                      '4.9',
                      style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _ReviewItem(
            name: 'Alex Smith',
            date: '2 days ago',
            comment: 'Best trading group I\'ve ever joined. Signals are accurate and support is amazing!',
          ),
          const _ReviewItem(
            name: 'Emma Wilson',
            date: '1 week ago',
            comment: 'Made back my investment in the first week. Highly recommended!',
          ),
          const _ReviewItem(
            name: 'John Doe',
            date: '2 weeks ago',
            comment: 'Great signals and community. Learning a lot from the analysis.',
          ),
          const _ReviewItem(
            name: 'Sarah Connor',
            date: '3 weeks ago',
            comment: 'Consistent results and very professional signals.',
          ),
          const _ReviewItem(
            name: 'Mike Ross',
            date: '1 month ago',
            comment: 'Perfect for beginners and advanced traders alike.',
          ),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String comment;

  const _ReviewItem({required this.name, required this.date, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(Icons.person_rounded, color: AppColors.mutedText, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          date,
                          style: TextStyle(color: AppColors.mutedText, fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 10)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(color: AppColors.mutedText, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}
