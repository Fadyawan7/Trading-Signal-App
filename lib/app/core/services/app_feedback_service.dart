import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';

enum AppFeedbackType { success, error, info }

class AppFeedbackService extends GetxService {
  void showSuccess({required String title, required String message}) {
    _show(title: title, message: message, type: AppFeedbackType.success);
  }

  void showError({required String title, required String message}) {
    _show(title: title, message: message, type: AppFeedbackType.error);
  }

  void showInfo({required String title, required String message}) {
    _show(title: title, message: message, type: AppFeedbackType.info);
  }

  void _show({
    required String title,
    required String message,
    required AppFeedbackType type,
  }) {
    final style = _FeedbackStyle.fromType(type);

    Get.closeAllSnackbars();
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 18,
      backgroundColor: AppColors.card,
      borderColor: style.borderColor,
      borderWidth: 1,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
      titleText: Text(
        title,
        style: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: AppColors.mutedText,
          fontSize: 13,
          height: 1.35,
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(left: 6, right: 4),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(style.icon, color: style.iconColor, size: 20),
        ),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}

class _FeedbackStyle {
  const _FeedbackStyle({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;

  factory _FeedbackStyle.fromType(AppFeedbackType type) {
    switch (type) {
      case AppFeedbackType.success:
        return _FeedbackStyle(
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.success,
          backgroundColor: AppColors.success.withValues(alpha: 0.12),
          borderColor: AppColors.success.withValues(alpha: 0.25),
        );
      case AppFeedbackType.error:
        return _FeedbackStyle(
          icon: Icons.error_rounded,
          iconColor: AppColors.error,
          backgroundColor: AppColors.error.withValues(alpha: 0.12),
          borderColor: AppColors.error.withValues(alpha: 0.22),
        );
      case AppFeedbackType.info:
        return _FeedbackStyle(
          icon: Icons.info_rounded,
          iconColor: AppColors.info,
          backgroundColor: AppColors.info.withValues(alpha: 0.12),
          borderColor: AppColors.info.withValues(alpha: 0.22),
        );
    }
  }
}
