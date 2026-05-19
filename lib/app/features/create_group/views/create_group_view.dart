import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  final controller = Get.find<CreateGroupViewModel>();

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

  void _showImageSourceBottomSheet(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Image Source',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.primary),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Get.back();
                  controller.pickGroupIcon(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                title: const Text('Capture with Camera'),
                onTap: () {
                  Get.back();
                  controller.pickGroupIcon(ImageSource.camera);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
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
        child: Obx(() {
          final showLoading = controller.isLoading.value;
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  const SizedBox(height: 10),
                  const Text('Group Icon', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Obx(() {
                    final path = controller.groupIconPath.value;
                    return InkWell(
                      onTap: () => _showImageSourceBottomSheet(context),
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 2),
                          image: path.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(File(path)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: path.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload, color: AppColors.mutedText),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Upload',
                                    style: TextStyle(fontSize: 11, color: AppColors.mutedText),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  Text(
                    'Recommended: 512x512px, PNG or JPG',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedText),
                  ),
                  const SizedBox(height: 12),
                  MarketTextInput(
                    label: 'Group Name *',
                    hint: 'e.g., Crypto Elite Signals',
                    controller: controller.groupNameController,
                  ),
                  const SizedBox(height: 12),
                  const Text('Category *', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Obx(() {
                    final list = controller.rxCategories;
                    final selected = controller.selectedCategory.value;
                    if (list.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: CircularProgressIndicator(color: AppColors.primary),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (_, i) {
                        final c = list[i];
                        final active = selected?.id == c.id;
                        return InkWell(
                          onTap: () => controller.selectedCategory.value = c,
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
                                    color: AppColors.primary.withValues(alpha: 0.15),
                                  ),
                                  child: c.icon != null && c.icon!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            c.icon!,
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Icon(
                                              Icons.currency_bitcoin,
                                              size: 20,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.currency_bitcoin,
                                          size: 20,
                                          color: AppColors.primary,
                                        ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  c.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 12),
                  const Text('Pricing *', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Obx(() {
                    final mode = controller.pricingType.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: _pricing('free', 'Free', 'Open to everyone', mode)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _pricing('paid', 'Paid', 'Set subscription fee', mode),
                            ),
                          ],
                        ),
                        if (mode == 'paid') ...[
                          const SizedBox(height: 8),
                          MarketTextInput(
                            hint: '99',
                            prefix: const Icon(Icons.attach_money),
                            controller: controller.priceController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ],
                      ],
                    );
                  }),
                  Obx(() {
                    final isPaid = controller.pricingType.value == 'paid';
                    if (!isPaid) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Offer Trial Period',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Switch(
                              value: controller.hasTrial.value,
                              activeColor: AppColors.primary,
                              onChanged: (val) => controller.hasTrial.value = val,
                            ),
                          ],
                        ),
                        if (controller.hasTrial.value) ...[
                          const SizedBox(height: 8),
                          MarketTextInput(
                            label: 'Trial Days *',
                            hint: 'e.g., 7',
                            controller: controller.trialDaysController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ],
                    );
                  }),
                  const SizedBox(height: 12),
                  MarketTextInput(
                    label: 'Maximum Members *',
                    hint: 'e.g., 1000',
                    controller: controller.maximumMembersController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  MarketTextInput(
                    label: 'Description *',
                    hint:
                        'Describe your trading group, strategy, and what members can expect...',
                    controller: controller.descriptionController,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Group Features *',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final selectedSet = controller.selectedFeatures;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: features.map((f) {
                        final active = selectedSet.contains(f);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: InkWell(
                            onTap: () => active ? selectedSet.remove(f) : selectedSet.add(f),
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
                                      color: active ? AppColors.primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: active ? AppColors.primary : AppColors.border,
                                      ),
                                    ),
                                    child: active ? const Icon(Icons.check, size: 14) : null,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(f, style: const TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Only Admin Can Message',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Obx(() => Switch(
                            value: controller.onlyAdminCanMessage.value,
                            activeColor: AppColors.primary,
                            onChanged: (val) => controller.onlyAdminCanMessage.value = val,
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MarketPanel(
                    radius: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '✨ Ready to launch?',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
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
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    onTap: () => controller.submitGroup(),
                  ),
                ],
              ),
              if (showLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black45,
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _pricing(String id, String label, String sub, String activeId) {
    final active = activeId == id;
    return InkWell(
      onTap: () => controller.pricingType.value = id,
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
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
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
