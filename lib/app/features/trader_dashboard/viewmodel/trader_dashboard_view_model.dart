import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../theme/app_colors.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../data/models/trader_dashboard_response.dart';

class TraderDashboardViewModel extends BaseViewModel {
  final _traderRepository = Get.find<TraderRepository>();

  final title = 'Trader Dashboard';
  final subtitle = 'Performance snapshot, subscribers, and signals.';
  final cta = 'Create Group';

  // Observable dashboard data
  final rxDashboardData = Rxn<TraderDashboardData>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.getTraderDashboard();
          if (response.status && response.data != null) {
            rxDashboardData.value = response.data;
          } else {
            showError(response.message);
          }
        }
      } on ApiException catch (error) {
        showError(error.message);
      } catch (e) {
        showError('Failed to load dashboard data.');
        debugPrint('Dashboard fetch error: $e');
      }
    });
  }

  Future<void> submitDeleteGroupRequest(int groupId, String reason) async {
    if (reason.trim().isEmpty) {
      showError('Please enter a deletion reason.');
      return;
    }

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.deleteTraderGroup(
            groupId: groupId,
            reason: reason.trim(),
          );

          if (response.status) {
            Get.snackbar(
              'Success',
              response.message,
              backgroundColor: Colors.green.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
            fetchDashboardData();
          } else {
            showError(response.message);
          }
        }
      } on ApiException catch (e) {
        showError(e.message);
      } catch (e) {
        showError('Failed to submit delete request.');
        debugPrint('Delete group error: $e');
      }
    });
  }

  void showDeleteGroupDialog(BuildContext context, int groupId) {
    final reasonController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withValues(alpha: 0.1),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 1.5),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Beautiful Warning Icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red.shade400,
                        Colors.red.shade900,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.warning_rounded, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 24),
                Text(
                  'Delete Group?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'This will submit a request to the administrator to permanently delete your trading group. Please tell us your reason below:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.text, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Reason for deletion (e.g., merging groups)...',
                    hintStyle: TextStyle(color: AppColors.mutedText.withValues(alpha: 0.5), fontSize: 13),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.5), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final reason = reasonController.text.trim();
                        if (reason.isEmpty) {
                          showError('Please state a reason for deletion.');
                          return;
                        }
                        Get.back();
                        submitDeleteGroupRequest(groupId, reason);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Delete Group',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
