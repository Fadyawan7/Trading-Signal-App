import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/edit_profile_view_model.dart';

class EditProfileView extends GetView<EditProfileViewModel> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EditProfileBody();
  }
}

class _EditProfileBody extends StatefulWidget {
  const _EditProfileBody();

  @override
  State<_EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<_EditProfileBody> {
  String avatar = '👤';
  final avatars = [
    '👤',
    '👨',
    '👩',
    '🧑',
    '👨‍💼',
    '👩‍💼',
    '🧑‍💼',
    '😎',
    '🤵',
    '👔',
    '💼',
    '🎯',
    '🚀',
    '💎',
    '⚡',
    '🔥',
  ];

  final name = TextEditingController(text: 'Alex Smith');
  final email = TextEditingController(text: 'alex.smith@email.com');
  final phone = TextEditingController(text: '+92 300 1234567');
  final bio = TextEditingController(
    text: 'Passionate trader exploring crypto and forex markets.',
  );

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    bio.dispose();
    super.dispose();
  }

  void save() {
    Get.offNamed(AppRoutes.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
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
            size: 20,
            color: AppColors.text,
          ),
        ),
        actions: [
          Icon(Icons.save, size: 20, color: AppColors.text),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                      ),
                      child: Text(avatar, style: TextStyle(fontSize: 52)),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                          border: Border.all(color: AppColors.card, width: 3),
                        ),
                        child: Icon(Icons.camera_alt, size: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose your avatar',
                  style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: avatars.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (_, i) {
                final a = avatars[i];
                final selected = a == avatar;
                return InkWell(
                  onTap: () => setState(() => avatar = a),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: selected
                          ? const LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            )
                          : null,
                      color: selected ? null : AppColors.card,
                      border: Border.all(
                        color: selected ? Colors.transparent : AppColors.border,
                      ),
                    ),
                    child: Text(a, style: TextStyle(fontSize: 22)),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            MarketTextInput(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: name,
              prefix: Icon(Icons.person_outline),
            ),
            const SizedBox(height: 10),
            MarketTextInput(
              label: 'Email Address',
              hint: 'Enter your email',
              controller: email,
              prefix: Icon(Icons.mail_outline),
            ),
            const SizedBox(height: 10),
            MarketTextInput(
              label: 'Phone Number',
              hint: 'Enter your phone number',
              controller: phone,
              prefix: Icon(Icons.phone_outlined),
            ),
            const SizedBox(height: 10),
            MarketTextInput(
              label: 'Bio',
              hint: 'Tell us about yourself',
              controller: bio,
              prefix: Icon(Icons.message_outlined),
              maxLines: 4,
            ),
            const SizedBox(height: 4),
            Text(
              '${bio.text.length}/200 characters',
              style: TextStyle(fontSize: 11, color: AppColors.mutedText),
            ),
            const SizedBox(height: 14),
            MarketPanel(
              radius: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Information',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  _info('Member Since', 'January 2026'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _InfoRow(
                          label: 'Account Status',
                          value: 'Active User',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: Colors.green.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          'Verified ✓',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            PrimaryButton(
              label: 'Save Changes',
              icon: Icon(Icons.save, size: 16),
              onTap: save,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: Get.back,
              child: MarketPanel(
                radius: 12,
                padding: const EdgeInsets.all(14),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) =>
      _InfoRow(label: label, value: value);
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: AppColors.mutedText)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
