import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/connectivity_service.dart';
import '../theme/app_colors.dart';

class AppNetworkBanner extends GetView<ConnectivityService> {
  const AppNetworkBanner({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          child,
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            child: IgnorePointer(
              ignoring: controller.isConnected.value,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 250),
                offset: controller.isConnected.value
                    ? const Offset(0, -1.4)
                    : Offset.zero,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: controller.isConnected.value ? 0 : 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.warning.withValues(alpha: 0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.wifi_off_rounded,
                            color: AppColors.warning,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You are offline. Reconnect to continue API requests.',
                            style: TextStyle(
                              color: AppColors.text,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
