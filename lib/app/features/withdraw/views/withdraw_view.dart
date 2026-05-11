import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/withdraw_view_model.dart';

class WithdrawView extends GetView<WithdrawViewModel> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Withdraw',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Exbotix UID',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            _buildInput(
              hint: 'Enter your Exbotix UID',
              icon: Icons.person_outline,
              onChanged: controller.setUid,
            ),
            const SizedBox(height: 24),
            Text(
              'Withdraw Amount (USDT)',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            _buildInput(
              hint: '0.00',
              onChanged: controller.setAmount,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            _FeeSummaryCard(),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.shield_outlined, color: AppColors.success, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Withdrawals are processed within 24 hours',
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _WithdrawButton(),
          ],
        ),
      ),
      )
    );
  }

  Widget _buildInput({
    required String hint,
    IconData? icon,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.mutedText, size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: TextField(
              onChanged: onChanged,
              keyboardType: keyboardType,
              style: TextStyle(color: AppColors.text, fontSize: 15),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: AppColors.mutedText.withOpacity(0.5)),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeSummaryCard extends GetView<WithdrawViewModel> {
  const _FeeSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildRow('Withdrawal Fee', '${controller.fee.value} USDT'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.border, height: 1),
          ),
          Obx(() => _buildRow(
                'You Will Receive',
                '${controller.receiveAmount.toStringAsFixed(2)} USDT',
                isHighlight: true,
              )),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? AppColors.primary : AppColors.text,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _WithdrawButton extends GetView<WithdrawViewModel> {
  const _WithdrawButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller.uid.isEmpty || controller.amount.isEmpty) {
          controller.showError('Please fill in all fields');
          return;
        }
        _showConfirmationDialog(context);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [AppColors.primary, const Color(0xFF0D9488)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Withdraw Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAB308).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFEAB308), size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                'Confirm Withdrawal',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildDialogRow('UID', controller.uid.value),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColors.border, height: 1),
              ),
              _buildDialogRow('Amount', '${controller.amount.value} USDT', isHighlight: true),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: controller.confirmWithdrawal,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [AppColors.primary, const Color(0xFF0D9488)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? AppColors.primary : AppColors.text,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
