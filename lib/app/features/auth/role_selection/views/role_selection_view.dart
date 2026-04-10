import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/market_ui.dart';
import '../viewmodel/role_selection_view_model.dart';

class RoleSelectionView extends GetView<RoleSelectionViewModel> {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketLayout(
      child: Stack(
        children: [
          const Positioned.fill(child: _RoleSelectionBg()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('👥', style: TextStyle(fontSize: 54)),
                    SizedBox(width: 8),
                    Text('📊', style: TextStyle(fontSize: 64)),
                    SizedBox(width: 8),
                    Text('💼', style: TextStyle(fontSize: 54)),
                  ],
                ),
                const SizedBox(height: 18),
                const Text('Choose Your Path', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('Join the TradeConnect community', style: TextStyle(color: AppColors.mutedText)),
                const SizedBox(height: 28),
                _RoleOption(
                  emoji: '👤',
                  title: 'Join as User',
                  subtitle: 'Join trading groups and receive signals from professional traders',
                  chips: const ['📊 Market Signals', '💬 Group Chat', '📈 Learn & Earn'],
                  onTap: () => Get.offAllNamed(AppRoutes.home),
                  chipColor: AppColors.primary,
                ),
                const SizedBox(height: 14),
                _RoleOption(
                  emoji: '🚀',
                  title: 'Become a Trader',
                  subtitle: 'Create trading groups, share signals, and earn from your expertise',
                  chips: const ['💰 Earn Revenue', '👥 Build Community', '🏆 Verified Badge'],
                  onTap: () => Get.toNamed(AppRoutes.applyTrader),
                  chipColor: AppColors.accent,
                ),
                const SizedBox(height: 22),
                const Text(
                  'Start your journey today • Switch roles anytime',
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

class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.chips,
    required this.onTap,
    required this.chipColor,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final List<String> chips;
  final VoidCallback onTap;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: MarketPanel(
        radius: 18,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 46)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.mutedText, height: 1.35)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.mutedText),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              alignment: WrapAlignment.start,
              children: chips
                  .map(
                    (chip) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: chipColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        chip,
                        style: TextStyle(color: chipColor, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleSelectionBg extends StatelessWidget {
  const _RoleSelectionBg();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GridBgPainter(),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.16),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(alpha: 0.18),
            ),
          ),
        ),
      ],
    );
  }
}

class _GridBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x106366F1);
    const gap = 60.0;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
