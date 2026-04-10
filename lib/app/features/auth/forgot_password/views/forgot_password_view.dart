import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/market_ui.dart';
import '../viewmodel/forgot_password_view_model.dart';

class ForgotPasswordView extends GetView<ForgotPasswordViewModel> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketLayout(
      child: Stack(
        children: [
          const Positioned.fill(child: _ForgotBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: iconSquare(icon: Icons.arrow_back, onTap: Get.back),
                ),
                const SizedBox(height: 20),
                const _Header(),
                const SizedBox(height: 30),
                const MarketTextInput(
                  label: 'Email',
                  hint: 'Enter your registered email',
                  prefix: Icon(Icons.mail_outline),
                ),
                const SizedBox(height: 14),
                const Text(
                  'We will send a password reset link to your email address.',
                  style: TextStyle(color: AppColors.mutedText),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: 'Send Reset Link',
                  icon: const Icon(
                    Icons.send_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Get.snackbar(
                      'Reset Link Sent',
                      'Check your inbox and follow the instructions.',
                      backgroundColor: AppColors.card,
                      colorText: AppColors.text,
                      margin: const EdgeInsets.all(12),
                    );
                    if (Get.key.currentState?.canPop() == true) {
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LogoBox(),
        SizedBox(height: 12),
        Text(
          'Forgot Password?',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6),
        Text(
          'Recover your account in a few steps',
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
        Icons.lock_reset_rounded,
        size: 52,
        color: Colors.white,
      ),
    );
  }
}

class _ForgotBackground extends StatelessWidget {
  const _ForgotBackground();

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
