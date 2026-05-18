import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/services/session_service.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';

class EditProfileViewModel extends BaseViewModel {
  EditProfileViewModel({
    required ProfileRepository profileRepository,
    required SessionService sessionService,
  }) : _profileRepository = profileRepository,
       _sessionService = sessionService;

  final ProfileRepository _profileRepository;
  final SessionService _sessionService;

  final title = 'Edit Profile';
  final subtitle = 'Update your bio, links, and account information.';
  final cta = 'Update Profile';

  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final avatar = '👤'.obs;

  @override
  void onInit() {
    super.onInit();
    final user = _sessionService.user;
    if (user != null) {
      nameController.text = user.name;
      bioController.text = user.bio ?? '';
      if (user.avatar != null && user.avatar!.isNotEmpty) {
        avatar.value = user.avatar!;
      }
    }
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    final bio = bioController.text.trim();

    if (name.isEmpty) {
      showError('Name is required');
      return;
    }

    bool isSuccess = false;
    String? successMessage;

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _profileRepository.updateProfile(
            name: name,
            bio: bio,
            avatar: avatar.value,
          );
          await _sessionService.updateUser(response.user);
          successMessage = response.message;
          isSuccess = true;
        }
      } on ApiException catch (error) {
        showError(error.message);
      } catch (_) {
        showError('Failed to update profile.');
      }
    });

    if (isSuccess) {
      Get.back();
      if (successMessage != null) {
        showSuccess(successMessage!);
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
