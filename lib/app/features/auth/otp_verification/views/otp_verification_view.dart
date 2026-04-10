import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/market_ui.dart';
import '../viewmodel/otp_verification_view_model.dart';

class OtpVerificationView extends GetView<OtpVerificationViewModel> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OtpBody();
  }
}

class _OtpBody extends StatefulWidget {
  const _OtpBody();

  @override
  State<_OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<_OtpBody> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());
  bool _loading = false;

  String get _otp => _controllers.map((e) => e.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  Future<void> _verify() async {
    if (_otp.length != 6) return;
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    Get.offAllNamed(AppRoutes.roleSelection);
  }

  @override
  Widget build(BuildContext context) {
    return MarketLayout(
      child: Stack(
        children: [
          const Positioned.fill(child: _OtpBackground()),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: iconSquare(icon: Icons.arrow_back, onTap: Get.back),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 112,
                                height: 112,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.accent,
                                      AppColors.primary,
                                    ],
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
                                  Icons.shield_outlined,
                                  size: 56,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 22),
                              const Text(
                                'Verify Your Number',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Enter the 6-digit code sent to\n+92 300 1234567',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.mutedText),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: 48,
                                    child: TextField(
                                      controller: _controllers[index],
                                      focusNode: _nodes[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        fillColor: AppColors.card,
                                        filled: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: AppColors.border,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: AppColors.border,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          _nodes[index + 1].requestFocus();
                                        }
                                        if (value.isEmpty && index > 0) {
                                          _nodes[index - 1].requestFocus();
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 18),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  const Text(
                                    'Didn\'t receive code? ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.mutedText,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      for (final c in _controllers) {
                                        c.clear();
                                      }
                                      setState(() {});
                                    },
                                    child: const Text(
                                      'Resend',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 22),
                              Opacity(
                                opacity: _otp.length == 6 ? 1 : 0.5,
                                child: IgnorePointer(
                                  ignoring: _otp.length != 6 || _loading,
                                  child: PrimaryButton(
                                    label: _loading
                                        ? 'Verifying...'
                                        : 'Verify & Continue',
                                    onTap: _verify,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpBackground extends StatelessWidget {
  const _OtpBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (final size in [420.0, 340.0, 260.0])
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.18),
                width: 2,
              ),
            ),
          ),
        Positioned(
          top: 120,
          left: 20,
          child: Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 110,
          right: 20,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(alpha: 0.1),
            ),
          ),
        ),
      ],
    );
  }
}
