import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/market_ui.dart';
import '../viewmodel/register_view_model.dart';

class RegisterView extends GetView<RegisterViewModel> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketLayout(
      child: Stack(
        children: [
          const Positioned.fill(child: _RegisterBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const _RegisterHeader(),
                const SizedBox(height: 28),
                const MarketTextInput(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  prefix: Icon(Icons.person_outline),
                ),
                const SizedBox(height: 14),
                const MarketTextInput(
                  label: 'Email',
                  hint: 'Enter your email',
                  prefix: Icon(Icons.mail_outline),
                ),
                const SizedBox(height: 14),
                const MarketTextInput(
                  label: 'Password',
                  hint: 'Create a password',
                  prefix: Icon(Icons.lock_outline),
                  obscure: true,
                ),
                const SizedBox(height: 14),
                const MarketTextInput(
                  label: 'Confirm Password',
                  hint: 'Confirm your password',
                  prefix: Icon(Icons.lock_outline),
                  obscure: true,
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Create Account',
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Colors.white,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.otpVerification),
                ),
                const SizedBox(height: 26),
                Row(
                  children: const [
                    Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: AppColors.mutedText),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: _SocialBtn(label: 'Google', icon: 'G'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _SocialBtn(label: 'Apple', icon: 'A'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text(
                      'By signing up, you agree to our ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mutedText,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Terms',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Text(
                      ' and ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mutedText,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: AppColors.mutedText),
                    ),
                    InkWell(
                      onTap: () {
                        if (Get.previousRoute == AppRoutes.login &&
                            Get.key.currentState?.canPop() == true) {
                          Get.back();
                          return;
                        }
                        Get.offNamed(AppRoutes.login);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LogoBox(),
        SizedBox(height: 12),
        Text(
          'Join TradeConnect',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6),
        Text(
          'Start your trading journey today',
          style: TextStyle(color: AppColors.mutedText),
        ),
      ],
    );
  }
}

class _LogoBox extends StatelessWidget {
  const _LogoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x6622C55E),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.trending_up_rounded,
        size: 52,
        color: Colors.white,
      ),
    );
  }
}

class _RegisterBackground extends StatelessWidget {
  const _RegisterBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _GridPainter())),
        const Positioned(
          top: 60,
          left: 30,
          child: _Orb(size: 220, c1: AppColors.primary, c2: AppColors.accent),
        ),
        const Positioned(
          bottom: 90,
          right: 10,
          child: _Orb(size: 250, c1: AppColors.accent, c2: AppColors.primary),
        ),
        const Positioned(
          top: 170,
          left: 200,
          child: _Orb(size: 140, c1: Color(0xFF16A34A), c2: Color(0xFF10B981)),
        ),
        const Positioned(
          top: 140,
          left: 70,
          child: Text(
            '💰',
            style: TextStyle(fontSize: 46, color: Colors.white10),
          ),
        ),
        const Positioned(
          top: 220,
          right: 60,
          child: Text(
            '📈',
            style: TextStyle(fontSize: 42, color: Colors.white10),
          ),
        ),
        const Positioned(
          bottom: 210,
          left: 110,
          child: Text(
            '💹',
            style: TextStyle(fontSize: 46, color: Colors.white10),
          ),
        ),
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.c1, required this.c2});

  final double size;
  final Color c1;
  final Color c2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [c1.withValues(alpha: 0.26), c2.withValues(alpha: 0.04)],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x336366F1);
    const gap = 56.0;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SocialBtn extends StatelessWidget {
  const _SocialBtn({required this.label, required this.icon});

  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
