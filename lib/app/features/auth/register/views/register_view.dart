import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_loading_overlay.dart';
import '../../../../widgets/market_ui.dart';
import '../viewmodel/register_view_model.dart';

class RegisterView extends GetView<RegisterViewModel> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        message: 'Creating your account...',
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const _LogoHeader(),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.border),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Start your trading journey today',
                                style: TextStyle(
                                  color: AppColors.mutedText,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 16),
                              MarketTextInput(
                                label: 'Full Name',
                                hint: 'John Doe',
                                controller: controller.nameController,
                                validator: controller.validateName,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.name],
                                prefix: const Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MarketTextInput(
                                label: 'Email',
                                hint: 'your.email@example.com',
                                controller: controller.emailController,
                                validator: controller.validateEmail,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.email],
                                prefix: const Icon(
                                  Icons.mail_outline,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MarketTextInput(
                                label: 'Referral Code',
                                hint: 'Optional referral code',
                                controller: controller.referralCodeController,
                                textInputAction: TextInputAction.next,
                                prefix: const Icon(
                                  Icons.sell_outlined,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MarketTextInput(
                                label: 'Password',
                                hint: 'Create a strong password',
                                controller: controller.passwordController,
                                validator: controller.validatePassword,
                                obscure: true,
                                enableObscureToggle: true,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [
                                  AutofillHints.newPassword,
                                ],
                                prefix: const Icon(
                                  Icons.lock_outline,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MarketTextInput(
                                label: 'Confirm Password',
                                hint: 'Confirm your password',
                                controller:
                                    controller.confirmPasswordController,
                                validator: controller.validateConfirmPassword,
                                obscure: true,
                                enableObscureToggle: true,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.newPassword,
                                ],
                                prefix: const Icon(
                                  Icons.lock_outline,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Password must include uppercase, lowercase, number, and special character.',
                                style: TextStyle(
                                  color: AppColors.mutedText,
                                  fontSize: 11,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _CreateAccountButton(onTap: controller.register),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(color: AppColors.mutedText),
                            ),
                            GestureDetector(
                              onTap: Get.back,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

class _LogoHeader extends StatelessWidget {
  const _LogoHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _LogoBox(),
        const SizedBox(height: 10),
        Text(
          'TradeConnect',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Trade smarter, earn better',
          style: TextStyle(color: AppColors.mutedText, fontSize: 14),
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
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(Icons.trending_up, size: 32, color: Colors.white),
    );
  }
}
