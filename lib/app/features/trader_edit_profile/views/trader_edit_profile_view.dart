import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/trader_edit_profile_view_model.dart';

class TraderEditProfileView extends GetView<TraderEditProfileViewModel> {
  const TraderEditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TraderEditBody();
  }
}

class _TraderEditBody extends StatefulWidget {
  const _TraderEditBody();

  @override
  State<_TraderEditBody> createState() => _TraderEditBodyState();
}

class _TraderEditBodyState extends State<_TraderEditBody> {
  String avatar = '👨‍💼';
  final avatars = [
    '👨‍💼',
    '👩‍💼',
    '🧑‍💼',
    '💼',
    '📊',
    '📈',
    '💰',
    '🎯',
    '🚀',
    '💎',
    '⚡',
    '🔥',
    '🏆',
    '⭐',
    '👔',
    '🤵',
  ];
  final experience = [
    'Beginner (< 1 year)',
    'Intermediate (1-3 years)',
    'Advanced (3-5 years)',
    'Expert (5+ years)',
  ];

  String selectedExp = 'Expert (5+ years)';

  void save() => Get.offNamed(AppRoutes.traderAccount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Trader Profile',),
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
            size: 20,
            color: AppColors.text,
          ),
        ),
        actions: [
          Icon(Icons.save, size: 20, color: AppColors.text),
          SizedBox(width: 20),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
           
            const SizedBox(height: 12),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                      ),
                      child: Text(avatar, style: const TextStyle(fontSize: 52)),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                          border: Border.all(color: AppColors.card, width: 3),
                        ),
                        child: const Icon(Icons.camera_alt, size: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.green.withValues(alpha: 0.1),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 3, backgroundColor: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        'Verified Trader',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: avatars.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (_, i) {
                final a = avatars[i];
                final active = a == avatar;
                return InkWell(
                  onTap: () => setState(() => avatar = a),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: active ? null : AppColors.card,
                      gradient: active
                          ? const LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            )
                          : null,
                      border: Border.all(
                        color: active ? Colors.transparent : AppColors.border,
                      ),
                    ),
                    child: Text(a, style: const TextStyle(fontSize: 22)),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Text(
              'Personal Information',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(label: 'Full Name', hint: 'John Martinez'),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Email Address',
              hint: 'john.martinez@tradepro.com',
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Phone Number',
              hint: '+92 300 9876543',
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Bio',
              hint: 'Professional trader with 8+ years of experience...',
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            const Text(
              'Trading Experience',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedExp,
                  isExpanded: true,
                  items: experience
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => selectedExp = v ?? selectedExp),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Specialization',
              hint: 'Crypto, Forex',
            ),
            const SizedBox(height: 12),
            const Text(
              'Performance Stats',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Expanded(
                  child: MarketTextInput(
                    label: 'Average ROI (%)',
                    hint: '94',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: MarketTextInput(
                    label: 'Win Rate (%)',
                    hint: '78',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Trading Strategy',
              hint: 'Describe your trading approach and methodology',
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            const Text(
              'Social Links',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(label: 'Twitter/X', hint: '@johntrader'),
            const SizedBox(height: 8),
            const MarketTextInput(label: 'Telegram', hint: '@johnmartinez'),
            const SizedBox(height: 12),
            MarketPanel(
              radius: 14,
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatItem(
                        value: '1,270',
                        label: 'Followers',
                        color: AppColors.primary,
                      ),
                      _StatItem(
                        value: '3',
                        label: 'Groups',
                        color: AppColors.accent,
                      ),
                      _StatItem(
                        value: '4.8',
                        label: 'Rating',
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Save Changes',
              icon: const Icon(Icons.save, size: 16),
              onTap: save,
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: Get.back,
              child: const MarketPanel(
                radius: 12,
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });
  final String value;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.mutedText, fontSize: 11),
        ),
      ],
    );
  }
}
