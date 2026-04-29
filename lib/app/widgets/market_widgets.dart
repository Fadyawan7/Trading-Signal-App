import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'market_ui.dart';

class MarketCard extends StatelessWidget {
  const MarketCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class AccentButton extends StatelessWidget {
  const AccentButton({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: label,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    );
  }
}
