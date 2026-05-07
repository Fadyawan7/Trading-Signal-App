import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/edit_profile_view_model.dart';

class EditProfileView extends GetView<EditProfileViewModel> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
            const _EditProfileBody(),
          ],
        ),
      ),
    );
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
    '👤', '👨', '👩', '🧑', '👨‍💼', '👩‍💼', '🧑‍💼', '😎',
    '🤵', '👔', '💼', '🎯', '🚀', '💎', '⚡', '🔥',
  ];

  final nameController = TextEditingController(text: 'Alex Smith');
  final emailController = TextEditingController(text: 'alex.smith@email.com');
  final phoneController = TextEditingController(text: '+92 300 1234567');
  final bioController = TextEditingController(
    text: 'Passionate trader exploring crypto and forex markets.',
  );

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _Header(onSave: () => Get.offNamed(AppRoutes.profile)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              children: [
                // Avatar Selection
                _AvatarSection(
                  currentAvatar: avatar,
                  onAvatarSelected: (a) => setState(() => avatar = a),
                  avatars: avatars,
                ),
                const SizedBox(height: 24),
                
                // Form Fields
                _InputField(
                  label: 'Full Name',
                  icon: Icons.person_outline_rounded,
                  controller: nameController,
                  hint: 'Enter your name',
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  controller: emailController,
                  hint: 'Enter your email',
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  controller: phoneController,
                  hint: 'Enter phone number',
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: 'Bio',
                  icon: Icons.message_outlined,
                  controller: bioController,
                  hint: 'Tell us about yourself',
                  maxLines: 3,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${bioController.text.length}/200 characters',
                    style: TextStyle(color: AppColors.mutedText, fontSize: 10),
                  ),
                ),
                
                const SizedBox(height: 24),
                Text(
                  'Account Information',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _AccountInfoCard(label: 'Member Since', value: 'January 2026'),
                const SizedBox(height: 10),
                _AccountInfoCard(
                  label: 'Account Status',
                  value: 'Active User',
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14B8A6).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF14B8A6).withValues(alpha: 0.2)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Color(0xFF14B8A6),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.check_circle_outline, color: Color(0xFF14B8A6), size: 12),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                // Buttons
                _ActionButton(
                  label: 'Save Changes',
                  icon: Icons.save_rounded,
                  isPrimary: true,
                  onTap: () => Get.offNamed(AppRoutes.profile),
                ),
                const SizedBox(height: 10),
                _ActionButton(
                  label: 'Cancel',
                  isPrimary: false,
                  onTap: () => Get.back(),
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
  final VoidCallback onSave;
  const _Header({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text, size: 18),
            ),
          ),
          Text(
            'Edit Profile',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: onSave,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF14B8A6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF14B8A6).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.save_as_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarSection extends StatelessWidget {
  final String currentAvatar;
  final Function(String) onAvatarSelected;
  final List<String> avatars;

  const _AvatarSection({
    required this.currentAvatar,
    required this.onAvatarSelected,
    required this.avatars,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: Center(
                child: Text(
                  currentAvatar,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 16),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(Icons.camera_alt_outlined, color: AppColors.text, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Choose your avatar',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 84,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final a = avatars[index];
              final isSelected = a == currentAvatar;
              return InkWell(
                onTap: () => onAvatarSelected(a),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(a, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.mutedText, fontSize: 13),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const _AccountInfoCard({
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isPrimary ? null : AppColors.card,
          gradient: isPrimary
              ? const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                )
              : null,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary ? null : Border.all(color: AppColors.border),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
