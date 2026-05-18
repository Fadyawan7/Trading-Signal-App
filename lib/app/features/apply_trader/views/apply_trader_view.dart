import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_loading_overlay.dart';
import '../viewmodel/apply_trader_view_model.dart';

class ApplyTraderView extends GetView<ApplyTraderViewModel> {
  const ApplyTraderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        message: 'Submitting application...',
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              // Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.backgroundSecondary,
                        AppColors.background,
                      ],
                    ),
                  ),
                ),
              ),
              const _ApplyTraderBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ApplyTraderBody extends GetView<ApplyTraderViewModel> {
  const _ApplyTraderBody();

  @override
  Widget build(BuildContext context) {
    final levels = const [
      'Beginner (< 1 year)',
      'Intermediate (1-3 years)',
      'Advanced (3-5 years)',
      'Expert (5+ years)',
    ];

    return SafeArea(
      child: Column(
        children: [
          const _Header(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: [
                const _InfoCard(),
                const SizedBox(height: 24),
                
                const _SectionTitle('Personal Information'),
                const SizedBox(height: 12),
                _InputField(
                  label: 'Full Name *',
                  hint: 'Enter your full name',
                  controller: controller.fullNameController,
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 16),
                Obx(() => _ExperienceDropdown(
                  value: controller.experienceLevel.value,
                  items: levels,
                  onChanged: (v) => controller.experienceLevel.value = v ?? '',
                )),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Specialization *',
                  hint: 'e.g., Crypto, Forex, Stocks',
                  controller: controller.specializationController,
                  icon: Icons.psychology_outlined,
                ),
                const SizedBox(height: 24),

                const _SectionTitle('Trading Profile'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Average ROI (%)',
                        hint: 'e.g., 85',
                        controller: controller.roiController,
                        icon: Icons.trending_up_rounded,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _InputField(
                        label: 'Win Rate (%) *',
                        hint: 'e.g., 75',
                        controller: controller.winRateController,
                        icon: Icons.percent_rounded,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Trading Strategy *',
                  hint: 'Describe your trading strategy and approach...',
                  controller: controller.tradingStrategyController,
                  icon: Icons.explore_outlined,
                  maxLines: 4,
                ),
                const SizedBox(height: 24),

                const _SectionTitle('Verification Documents'),
                const SizedBox(height: 12),
                
                // Identity Verification Front & Back
                Text(
                  'Identity Verification (Front is Required) *',
                  style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => _UploadCard(
                        title: 'Front View *',
                        fileName: controller.identityFrontPath.value.isNotEmpty
                            ? controller.identityFrontPath.value.split('/').last
                            : null,
                        onTap: () => controller.pickIdentityFront(),
                      )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => _UploadCard(
                        title: 'Back View (Optional)',
                        fileName: controller.identityBackPath.value.isNotEmpty
                            ? controller.identityBackPath.value.split('/').last
                            : null,
                        onTap: () => controller.pickIdentityBack(),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Trading Proof (1 to 5 files)
                Text(
                  'Trading History/Proof (1 to 5 proofs required) *',
                  style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Obx(() => _UploadCard(
                  title: 'Upload Trading Proof (${controller.tradingProofsPaths.length}/5)',
                  fileName: null,
                  line1: 'Click to upload proof of performance',
                  line2: 'PNG, JPG, PDF (Max 10MB)',
                  onTap: () => controller.addTradingProof(),
                )),
                const SizedBox(height: 8),
                // Show uploaded proofs list with remove buttons
                Obx(() {
                  if (controller.tradingProofsPaths.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Proofs:',
                          style: TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.tradingProofsPaths.length,
                          separatorBuilder: (context, index) => const Divider(height: 12, thickness: 0.5),
                          itemBuilder: (context, index) {
                            final path = controller.tradingProofsPaths[index];
                            final name = path.split('/').last;
                            return Row(
                              children: [
                                Icon(Icons.insert_drive_file_outlined, color: AppColors.primary, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColors.text, fontSize: 12),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.removeTradingProof(index),
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.close_rounded, color: Colors.redAccent, size: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),

                const _SectionTitle('Social Links (Optional)'),
                const SizedBox(height: 12),
                _InputField(
                  label: 'Twitter/X',
                  hint: 'https://twitter.com/username',
                  controller: controller.twitterController,
                  icon: Icons.link_rounded,
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Telegram',
                  hint: '@username',
                  controller: controller.telegramController,
                  icon: Icons.send_rounded,
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Why do you want to become a trader on TradeConnect?',
                  hint: 'Tell us about your motivation and goals...',
                  controller: controller.whyTradeConnectController,
                  icon: Icons.question_answer_outlined,
                  maxLines: 4,
                ),
                const SizedBox(height: 20),

                Obx(() => _ConsentBox(
                  value: controller.termsAccepted.value,
                  onChanged: (v) => controller.termsAccepted.value = v ?? false,
                )),
                const SizedBox(height: 28),

                _PrimaryButton(
                  label: 'Submit Application',
                  onTap: () => controller.submitApplication(),
                ),
                const SizedBox(height: 12),
                Text(
                  'Choose your plan to complete trader registration',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                ),
                const SizedBox(height: 30),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text, size: 18),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apply as Trader',
                style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Share your trading expertise',
                style: TextStyle(color: AppColors.mutedText, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF14B8A6).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF14B8A6).withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF14B8A6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.shield_outlined, color: Color(0xFF14B8A6), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Become a Verified Trader',
                  style: TextStyle(color: Color(0xFF14B8A6), fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Text(
                  'Share your trading expertise and build a community while earning from your skills. All applications are reviewed within 24-48 hours.',
                  style: TextStyle(color: AppColors.text.withValues(alpha: 0.7), fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label, hint;
  final int maxLines;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(icon, color: AppColors.primary, size: 14),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
            ),
          ],
        ),

        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(color: AppColors.text, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF14B8A6), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const _ExperienceDropdown({required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.workspace_premium_outlined, color: AppColors.primary, size: 14),
            const SizedBox(width: 6),
            Text('Trading Experience *', style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.isEmpty ? null : value,
              hint: const Text('Select your experience level', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
              isExpanded: true,
              dropdownColor: AppColors.card,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.mutedText),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: AppColors.text, fontSize: 14)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadCard extends StatelessWidget {
  final String title;
  final String? fileName;
  final String? line1;
  final String? line2;
  final VoidCallback onTap;

  const _UploadCard({
    required this.title,
    this.fileName,
    this.line1,
    this.line2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null && fileName!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: AppColors.mutedText, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: hasFile ? const Color(0xFF14B8A6).withValues(alpha: 0.05) : AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasFile ? const Color(0xFF14B8A6) : AppColors.border,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  hasFile ? Icons.check_circle_outline_rounded : Icons.file_upload_outlined,
                  color: hasFile ? const Color(0xFF14B8A6) : AppColors.mutedText,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  hasFile ? 'Selected File' : (line1 ?? 'Upload verification file'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasFile ? fileName! : (line2 ?? 'PNG, JPG (Max 5MB)'),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hasFile ? const Color(0xFF14B8A6) : AppColors.mutedText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ConsentBox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const _ConsentBox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF14B8A6).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF14B8A6).withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF14B8A6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: AppColors.text, fontSize: 12, height: 1.5),
                children: [
                  const TextSpan(text: 'I confirm that all information provided is accurate and I agree to the '),
                  TextSpan(
                    text: 'Trader Terms & Conditions',
                    style: TextStyle(color: const Color(0xFF14B8A6), fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Community Guidelines',
                    style: TextStyle(color: const Color(0xFF14B8A6), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF0D9488)]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: const Color(0xFF10B981).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
