import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/create_group_view_model.dart';

class CreateGroupView extends GetView<CreateGroupViewModel> {
  const CreateGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CreateGroupBody();
  }
}

class _CreateGroupBody extends StatefulWidget {
  const _CreateGroupBody();

  @override
  State<_CreateGroupBody> createState() => _CreateGroupBodyState();
}

class _CreateGroupBodyState extends State<_CreateGroupBody> {
  String? selectedCategory;
  String pricingType = 'free';
  final selectedFeatures = <String>{};

  final categories = const [
    {'name': 'Crypto', 'icon': '💰'},
    {'name': 'Forex', 'icon': '💵'},
    {'name': 'Gold', 'icon': '🏆'},
    {'name': 'Stocks', 'icon': '📊'},
    {'name': 'Commodities', 'icon': '⚡'},
    {'name': 'NFTs', 'icon': '🎨'},
  ];

  final features = const [
    'Real-time trading signals',
    'Market analysis reports',
    '24/7 support',
    'Risk management guidance',
    'Educational content',
    'Technical analysis',
    'Weekly webinars',
    'Private chat access',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Trading Group',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              'Build your trading community',
              style: TextStyle(color: AppColors.mutedText, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        centerTitle: true,
        surfaceTintColor: AppColors.background,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: AppColors.text,
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Group Icon', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload, color: AppColors.mutedText),
                  SizedBox(height: 4),
                  Text(
                    'Upload',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Recommended: 512x512px, PNG or JPG',
              style: TextStyle(fontSize: 11, color: AppColors.mutedText),
            ),
            const SizedBox(height: 12),
            const MarketTextInput(
              label: 'Group Name *',
              hint: 'e.g., Crypto Elite Signals',
            ),
            const SizedBox(height: 12),
            Text('Category *', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (_, i) {
                final c = categories[i];
                final active = selectedCategory == c['name'];
                return InkWell(
                  onTap: () => setState(() => selectedCategory = c['name']),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.card,
                      border: Border.all(
                        color: active ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            ),
                          ),
                          child: Text(
                            c['icon']! as String,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c['name']! as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Text('Pricing *', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _pricing('free', 'Free', 'Open to everyone')),
                const SizedBox(width: 8),
                Expanded(
                  child: _pricing('paid', 'Paid', 'Set subscription fee'),
                ),
              ],
            ),
            if (pricingType == 'paid') ...[
              const SizedBox(height: 8),
              const MarketTextInput(
                hint: '99',
                prefix: Icon(Icons.attach_money),
              ),
            ],
            const SizedBox(height: 12),
            const MarketTextInput(
              label: 'Maximum Members *',
              hint: 'e.g., 1000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const MarketTextInput(
              label: 'Description *',
              hint:
                  'Describe your trading group, strategy, and what members can expect...',
              maxLines: 5,
            ),
            const SizedBox(height: 12),
            Text(
              'Group Features *',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...features.map((f) {
              final active = selectedFeatures.contains(f);
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: InkWell(
                  onTap: () => setState(
                    () => active
                        ? selectedFeatures.remove(f)
                        : selectedFeatures.add(f),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.card,
                      border: Border.all(
                        color: active ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: active
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: active
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                          ),
                          child: active ? Icon(Icons.check, size: 14) : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(f, style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            MarketPanel(
              radius: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✨ Ready to launch?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Once created, your group will be reviewed and published within 24 hours. You\'ll receive an email confirmation.',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Create Trading Group',
              icon: Icon(Icons.arrow_forward, size: 16),
              onTap: () => Get.offNamed(AppRoutes.traderDashboard),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pricing(String id, String label, String sub) {
    final active = pricingType == id;
    return InkWell(
      onTap: () => setState(() => pricingType = id),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.card,
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: AppColors.mutedText),
            ),
          ],
        ),
      ),
    );
  }
}
