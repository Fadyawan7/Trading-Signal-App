import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/services/session_service.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';



class ApplyTraderViewModel extends BaseViewModel {
  ApplyTraderViewModel({
    required TraderRepository traderRepository,
    required SessionService sessionService,
  })  : _traderRepository = traderRepository,
        _sessionService = sessionService;

  final TraderRepository _traderRepository;
  final SessionService _sessionService;

  final title = 'Apply as Trader';
  final subtitle = 'Submit your proof and become a verified trader.';
  final cta = 'Submit Application';

  // Input Controllers
  final fullNameController = TextEditingController();
  final specializationController = TextEditingController();
  final roiController = TextEditingController();
  final winRateController = TextEditingController();
  final tradingStrategyController = TextEditingController();
  final twitterController = TextEditingController();
  final telegramController = TextEditingController();
  final whyTradeConnectController = TextEditingController();

  // Observable selections
  final experienceLevel = ''.obs;
  final termsAccepted = false.obs;

  // File Paths
  final identityFrontPath = ''.obs;
  final identityBackPath = ''.obs;
  final tradingProofsPaths = <String>[].obs;

  // Helper method to create a temporary dummy file on the filesystem
  // to support multipart file upload requests cleanly.
  Future<String> _createTempDummyFile(String fileName) async {
    try {
      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$fileName');
      if (!await file.exists()) {
        await file.create(recursive: true);
        await file.writeAsString('dummy file content for verification $fileName');
      }
      return file.path;
    } catch (e) {
      debugPrint('Error creating temp file: $e');
      return '';
    }
  }

  // Bottom sheet image source picker
  Future<String?> _pickImageSource() async {
    final dynamic choice = await Get.bottomSheet<dynamic>(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF1E293B), // Premium dark theme matching AppColors.card
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF475569),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Image Source',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: Color(0xFF10B981), size: 20),
                ),
                title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: const Text('Select an existing photo from your library', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                onTap: () => Get.back(result: 'gallery'),
              ),
              const Divider(color: Color(0xFF334155), height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D9488).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Color(0xFF0D9488), size: 20),
                ),
                title: const Text('Capture with Camera', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: const Text('Take a new photo using your camera', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                onTap: () => Get.back(result: 'camera'),
              ),
            ],
          ),
        ),
      ),
    );


    if (choice == 'gallery' || choice == 'camera') {
      try {
        final picker = ImagePicker();
        final source = choice == 'gallery' ? ImageSource.gallery : ImageSource.camera;
        final XFile? image = await picker.pickImage(source: source, imageQuality: 80);
        return image?.path;
      } catch (e) {
        showError('Permission denied or camera not available: $e');
        return null;
      }
    }
    return null;
  }

  // Pick uploading identity front
  Future<void> pickIdentityFront() async {
    final path = await _pickImageSource();
    if (path == null || path.isEmpty) return;

    identityFrontPath.value = path;
    showSuccess('Identity Front loaded successfully');
  }

  // Pick uploading identity back
  Future<void> pickIdentityBack() async {
    final path = await _pickImageSource();
    if (path == null || path.isEmpty) return;

    identityBackPath.value = path;
    showSuccess('Identity Back loaded successfully');
  }

  // Pick adding a trading proof
  Future<void> addTradingProof() async {
    if (tradingProofsPaths.length >= 5) {
      showError('You can upload a maximum of 5 trading proofs');
      return;
    }

    final path = await _pickImageSource();
    if (path == null || path.isEmpty) return;

    tradingProofsPaths.add(path);
    showSuccess('Trading proof ${tradingProofsPaths.length} uploaded successfully');
  }

  // Remove a trading proof
  void removeTradingProof(int index) {
    if (index >= 0 && index < tradingProofsPaths.length) {
      tradingProofsPaths.removeAt(index);
      showSuccess('Trading proof removed');
    }
  }


  Future<void> submitApplication() async {
    final fullName = fullNameController.text.trim();
    final experience = experienceLevel.value;
    final specialization = specializationController.text.trim();
    final roi = roiController.text.trim();
    final winRate = winRateController.text.trim();
    final strategy = tradingStrategyController.text.trim();
    final twitter = twitterController.text.trim();
    final telegram = telegramController.text.trim();
    final whyTradeConnect = whyTradeConnectController.text.trim();

    // Validation
    if (fullName.isEmpty) {
      showError('Full Name is required');
      return;
    }
    if (experience.isEmpty) {
      showError('Trading Experience is required');
      return;
    }
    if (specialization.isEmpty) {
      showError('Specialization is required');
      return;
    }
    if (winRate.isEmpty) {
      showError('Win Rate is required');
      return;
    }
    if (strategy.isEmpty) {
      showError('Trading Strategy description is required');
      return;
    }
    if (identityFrontPath.value.isEmpty) {
      showError('Identity Front verification document is required');
      return;
    }
    if (tradingProofsPaths.isEmpty) {
      showError('At least 1 trading proof is required');
      return;
    }
    if (!termsAccepted.value) {
      showError('You must agree to the terms and conditions');
      return;
    }

    bool isSuccess = false;
    String? successMessage;

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.applyAsTrader(
            fullName: fullName,
            tradingExperience: experience,
            specialization: specialization,
            winRate: winRate,
            tradingStrategy: strategy,
            identityFront: identityFrontPath.value,
            identityBack: identityBackPath.value.isNotEmpty ? identityBackPath.value : null,
            tradingProofs: tradingProofsPaths.toList(),
            twitter: twitter.isNotEmpty ? twitter : null,
            telegram: telegram.isNotEmpty ? telegram : null,
            whyTradeConnect: whyTradeConnect.isNotEmpty ? whyTradeConnect : null,
          );
          successMessage = response.message;
          isSuccess = response.status;
        }
      } on ApiException catch (error) {
        showError(error.message);
      } catch (e) {
        showError('Failed to submit application. Please try again.');
      }
    });

    if (isSuccess) {
      try {
        final profileRepository = Get.find<ProfileRepository>();
        final rolesResponse = await profileRepository.getUserRoles();
        if (rolesResponse.status && rolesResponse.data != null) {
          final data = rolesResponse.data!;
          final roles = data.roles.map((e) => e.name).toList();
          await _sessionService.saveRolesData(
            roles: roles,
            traderStatus: data.traderStatus,
            isSubscription: data.isSubscription,
          );
        }
      } catch (e) {
        debugPrint('Error updating roles after application: $e');
      }

      showSuccess(successMessage ?? 'Trader application submitted successfully');
      // Proceed to subscriptions
      Get.toNamed('/trader-subscription');
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    specializationController.dispose();
    roiController.dispose();
    winRateController.dispose();
    tradingStrategyController.dispose();
    twitterController.dispose();
    telegramController.dispose();
    whyTradeConnectController.dispose();
    super.onClose();
  }
}
