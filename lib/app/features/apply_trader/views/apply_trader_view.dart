import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/apply_trader_view_model.dart';

class ApplyTraderView extends GetView<ApplyTraderViewModel> {
  const ApplyTraderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ApplyTraderBody();
  }
}

class _ApplyTraderBody extends StatefulWidget {
  const _ApplyTraderBody();

  @override
  State<_ApplyTraderBody> createState() => _ApplyTraderBodyState();
}

class _ApplyTraderBodyState extends State<_ApplyTraderBody> {
  String experience = '';
  bool terms = false;

  final levels = const [
    'Beginner (< 1 year)',
    'Intermediate (1-3 years)',
    'Advanced (3-5 years)',
    'Expert (5+ years)',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      AppColors.background; // Trigger reactivity
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _Header(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  children: [
                    _InfoCard(),
                    const SizedBox(height: 24),
                    
                    _SectionTitle('Personal Information'),
                    const SizedBox(height: 12),
                    _InputField(label: 'Full Name', hint: 'Enter your full name'),
                    const SizedBox(height: 16),
                    _ExperienceDropdown(
                      value: experience,
                      items: levels,
                      onChanged: (v) => setState(() => experience = v ?? ''),
                    ),
                    const SizedBox(height: 16),
                    _InputField(label: 'Specialization', hint: 'e.g., Crypto, Forex, Stocks'),
                    const SizedBox(height: 24),

                    _SectionTitle('Trading Profile'),
                    const SizedBox(height: 12),
                    _InputField(label: 'Average ROI (%)', hint: 'e.g., 85%'),
                    const SizedBox(height: 16),
                    _InputField(label: 'Win Rate (%)', hint: 'e.g., 75%'),
                    const SizedBox(height: 16),
                    _InputField(
                      label: 'Trading Strategy',
                      hint: 'Describe your trading strategy and approach...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),

                    _SectionTitle('Verification Documents'),
                    const SizedBox(height: 12),
                    _UploadCard(
                      title: 'Trading History/Proof',
                      line1: 'Upload screenshots or reports',
                      line2: 'PNG, JPG, PDF (Max 10MB)',
                    ),
                    const SizedBox(height: 16),
                    _UploadCard(
                      title: 'Identity Verification',
                      line1: 'Upload ID or passport',
                      line2: 'PNG, JPG (Max 5MB)',
                    ),
                    const SizedBox(height: 24),

                    _SectionTitle('Social Links (Optional)'),
                    const SizedBox(height: 12),
                    _InputField(label: 'Twitter/X', hint: 'https://twitter.com/username'),
                    const SizedBox(height: 16),
                    _InputField(label: 'Telegram', hint: '@username'),
                    const SizedBox(height: 16),
                    _InputField(
                      label: 'Why do you want to become a trader on TradeConnect?',
                      hint: 'Tell us about your motivation and goals...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),

                    _ConsentBox(
                      value: terms,
                      onChanged: (v) => setState(() => terms = v ?? false),
                    ),
                    const SizedBox(height: 24),

                    _PrimaryButton(
                      label: 'Continue to Subscription',
                      onTap: () => Get.toNamed(AppRoutes.traderSubscription),
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
        ),
      );
    });
  }
}

class _Header extends StatelessWidget {
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
  const _InputField({required this.label, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
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
        Text('Trading Experience', style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
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
  final String title, line1, line2;
  const _UploadCard({required this.title, required this.line1, required this.line2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1.5),
          ),
          child: Column(
            children: [
              Icon(Icons.file_upload_outlined, color: AppColors.mutedText, size: 32),
              const SizedBox(height: 12),
              Text(line1, style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(line2, style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
            ],
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
