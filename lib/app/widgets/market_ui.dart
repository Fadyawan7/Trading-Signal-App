import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class MarketLayout extends StatelessWidget {
  const MarketLayout({
    super.key,
    required this.child,
    this.bottomNav,
    this.background,
  });

  final Widget child;
  final Widget? bottomNav;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background ?? AppColors.background,
      bottomNavigationBar: bottomNav,
      body: SafeArea(child: child),
    );
  }
}

class MarketPanel extends StatelessWidget {
  const MarketPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 16,
    this.borderColor,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? borderColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? AppColors.border),
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    this.fullWidth = true,
    this.borderRadius = 14,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final EdgeInsetsGeometry padding;
  final bool fullWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        width: fullWidth ? double.infinity : null,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5522C55E),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) ...[const SizedBox(width: 8), icon!],
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    this.fullWidth = true,
    this.borderRadius = 14,
    this.textColor = AppColors.text,
    this.borderColor = AppColors.border,
    this.backgroundColor = AppColors.card,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final EdgeInsetsGeometry padding;
  final bool fullWidth;
  final double borderRadius;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        width: fullWidth ? double.infinity : null,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
            ),
            if (icon != null) ...[const SizedBox(width: 8), icon!],
          ],
        ),
      ),
    );
  }
}

@Deprecated('Use PrimaryButton instead')
class GradientButton extends PrimaryButton {
  const GradientButton({
    super.key,
    required super.label,
    super.onTap,
    super.icon,
    super.padding,
  });
}

class MarketTextInput extends StatelessWidget {
  const MarketTextInput({
    super.key,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.controller,
    this.obscure = false,
    this.maxLines = 1,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  });

  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscure;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themedDecoration = Theme.of(context).inputDecorationTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          obscureText: obscure,
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 10, right: 6),
                    child: IconTheme(
                      data: const IconThemeData(color: AppColors.mutedText),
                      child: prefix!,
                    ),
                  ),
            suffixIcon: suffix,
          ).applyDefaults(themedDecoration),
        ),
      ],
    );
  }
}

class ChipPill extends StatelessWidget {
  const ChipPill({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = active
        ? const LinearGradient(colors: [AppColors.primary, AppColors.accent])
        : null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? null : AppColors.secondary,
          gradient: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : AppColors.mutedText,
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class MarketTopBar extends StatelessWidget {
  const MarketTopBar({
    super.key,
    this.onBack,
    required this.title,
    this.trailing,
    this.padding = const EdgeInsets.fromLTRB(24, 18, 24, 16),
  });

  final VoidCallback? onBack;
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (onBack != null)
            _iconSquare(icon: Icons.arrow_back, onTap: onBack!)
          else
            const SizedBox(width: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          trailing ?? const SizedBox(width: 40),
        ],
      ),
    );
  }
}

Widget iconSquare({
  required IconData icon,
  required VoidCallback onTap,
  Color? bg,
}) {
  return _iconSquare(icon: icon, onTap: onTap, bg: bg);
}

Widget _iconSquare({
  required IconData icon,
  required VoidCallback onTap,
  Color? bg,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bg ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 20),
    ),
  );
}

void navTo(
  String route, {
  dynamic args,
  bool clear = false,
  bool replace = false,
}) {
  if (clear) {
    Get.offAllNamed(route, arguments: args);
    return;
  }
  if (replace) {
    Get.offNamed(route, arguments: args);
    return;
  }
  Get.toNamed(route, arguments: args);
}
