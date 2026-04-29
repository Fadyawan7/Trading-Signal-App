import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 16, 24, 12),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Apply as Trader',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Share your trading expertise',
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 12),
            MarketPanel(
              radius: 14,
              color: AppColors.primary.withValues(alpha: 0.10),
              borderColor: AppColors.primary.withValues(alpha: 0.22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield, color: AppColors.primary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Become a Verified Trader',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Share your trading expertise and build a community while earning from your skills. All applications are reviewed within 24-48 hours.',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Personal Information',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Full Name',
              hint: 'Enter your full name',
            ),
            const SizedBox(height: 8),
            Text(
              'Trading Experience',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: experience.isEmpty ? null : experience,
                  hint: Text(
                    'Select your experience level',
                    style: TextStyle(color: AppColors.mutedText),
                  ),
                  isExpanded: true,
                  items: levels
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => experience = v ?? ''),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Specialization',
              hint: 'e.g., Crypto, Forex, Stocks',
            ),
            const SizedBox(height: 12),
            Text(
              'Trading Profile',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(label: 'Average ROI (%)', hint: 'e.g., 85%'),
            const SizedBox(height: 8),
            const MarketTextInput(label: 'Win Rate (%)', hint: 'e.g., 75%'),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Trading Strategy',
              hint: 'Describe your trading strategy and approach...',
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            Text(
              'Verification Documents',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _upload(
              'Trading History/Proof',
              'Upload screenshots or reports',
              'PNG, JPG, PDF (Max 10MB)',
            ),
            const SizedBox(height: 8),
            _upload(
              'Identity Verification',
              'Upload ID or passport',
              'PNG, JPG (Max 5MB)',
            ),
            const SizedBox(height: 12),
            Text(
              'Social Links (Optional)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Twitter/X',
              hint: 'https://twitter.com/username',
            ),
            const SizedBox(height: 8),
            const MarketTextInput(label: 'Telegram', hint: '@username'),
            const SizedBox(height: 8),
            const MarketTextInput(
              label: 'Why do you want to become a trader on TradeConnect?',
              hint: 'Tell us about your motivation and goals...',
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => setState(() => terms = !terms),
              child: MarketPanel(
                radius: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: terms,
                      onChanged: (v) => setState(() => terms = v ?? false),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'I confirm that all information provided is accurate and I agree to the Trader Terms & Conditions and Community Guidelines',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              label: 'Continue to Subscription',
              onTap: () => Get.toNamed(AppRoutes.traderSubscription),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose your plan to complete trader registration',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutedText, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _upload(String title, String line1, String line2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 2),
          ),
          child: Column(
            children: [
              Icon(Icons.upload, color: AppColors.mutedText),
              const SizedBox(height: 4),
              Text(line1, style: TextStyle(fontSize: 12)),
              Text(
                line2,
                style: TextStyle(fontSize: 10, color: AppColors.mutedText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
