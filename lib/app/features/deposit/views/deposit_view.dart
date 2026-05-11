import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/deposit_view_model.dart';

class DepositView extends GetView<DepositViewModel> {
  const DepositView({super.key});

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
          'Deposit',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _InfoCard(),
            const SizedBox(height: 20),
            _QrSection(),
            const SizedBox(height: 24),
            Text(
              'Enter USDT Amount',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            _AmountInput(),
            const SizedBox(height: 20),
            _WarningBox(),
            const SizedBox(height: 32),
            _ConfirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends GetView<DepositViewModel> {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildRow(
            label: 'NETWORK',
            value: controller.network.value,
            showLock: true,
            isHighlight: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.border, height: 1),
          ),
          _buildRow(
            label: 'WALLET ADDRESS',
            value: controller.walletAddress.value.substring(0, 4) + ' ... ' + controller.walletAddress.value.substring(controller.walletAddress.value.length - 4),
            showLock: true,
            hasCopy: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    bool showLock = false,
    bool isHighlight = false,
    bool hasCopy = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: isHighlight ? AppColors.primary : AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (hasCopy)
              InkWell(
                onTap: controller.copyAddress,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.copy, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      const Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (showLock && !hasCopy)
              Icon(Icons.lock_outline, color: AppColors.mutedText, size: 16),
          ],
        ),
      ],
    );
  }
}

class _QrSection extends StatelessWidget {
  const _QrSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.qr_code_2, size: 160, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            'Scan to Deposit',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountInput extends GetView<DepositViewModel> {
  const _AmountInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: controller.setAmount,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: Colors.transparent,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              'USDT',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningBox extends StatelessWidget {
  const _WarningBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1B12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAB308).withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: const Color(0xFFEAB308), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Send only USDT using the supported network. Sending other assets may result in permanent loss.',
              style: TextStyle(
                color: const Color(0xFFEAB308).withOpacity(0.8),
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF0D9488)],
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
          'Confirm Deposit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
