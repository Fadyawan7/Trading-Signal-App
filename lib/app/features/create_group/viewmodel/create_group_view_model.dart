import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../routes/app_routes.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../../trader_dashboard/viewmodel/trader_dashboard_view_model.dart';
import '../data/models/group_categories_response.dart';

class CreateGroupViewModel extends BaseViewModel {
  final _traderRepository = Get.find<TraderRepository>();

  final title = 'Create Group';
  final subtitle = 'Launch your premium signal community in minutes.';
  final cta = 'Publish Group';

  // Input Controllers
  final groupNameController = TextEditingController();
  final priceController = TextEditingController();
  final maximumMembersController = TextEditingController();
  final descriptionController = TextEditingController();
  final trialDaysController = TextEditingController(text: '0');

  // Observable states
  final groupIconPath = ''.obs;
  final rxCategories = <GroupCategory>[].obs;
  final selectedCategory = Rxn<GroupCategory>();
  final pricingType = 'free'.obs; // 'free' or 'paid'
  final hasTrial = false.obs;
  final onlyAdminCanMessage = true.obs;
  final selectedFeatures = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.getGroupCategories();
          if (response.status) {
            rxCategories.assignAll(response.data);
            if (response.data.isNotEmpty) {
              selectedCategory.value = response.data.first;
            }
          }
        }
      } catch (e) {
        debugPrint('Error fetching categories: $e');
      }
    });
  }

  Future<void> pickGroupIcon(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        groupIconPath.value = image.path;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      showError('Failed to select image.');
    }
  }

  Future<void> submitGroup() async {
    final name = groupNameController.text.trim();
    final category = selectedCategory.value;
    final maxMembersStr = maximumMembersController.text.trim();
    final description = descriptionController.text.trim();
    final priceStr = priceController.text.trim();

    if (name.isEmpty) {
      showError('Please enter a group name.');
      return;
    }
    if (category == null) {
      showError('Please select a category.');
      return;
    }
    if (maxMembersStr.isEmpty) {
      showError('Please enter maximum members.');
      return;
    }
    if (description.isEmpty) {
      showError('Please enter a group description.');
      return;
    }

    final int maxMembers = int.tryParse(maxMembersStr) ?? 0;
    if (maxMembers <= 0) {
      showError('Maximum members must be greater than zero.');
      return;
    }

    final double price = pricingType.value == 'paid' ? (double.tryParse(priceStr) ?? 0.0) : 0.0;
    if (pricingType.value == 'paid' && price <= 0.0) {
      showError('Please enter a valid price for a paid group.');
      return;
    }

    final trialDays = int.tryParse(trialDaysController.text) ?? 0;

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.createTraderGroup(
            groupName: name,
            categoryId: category.id,
            isPaid: pricingType.value == 'paid',
            price: price,
            hasTrial: hasTrial.value,
            trialDays: trialDays,
            maximumMembers: maxMembers,
            description: description,
            groupFeatures: selectedFeatures.toList(),
            onlyAdminCanMessage: onlyAdminCanMessage.value,
            groupIcon: groupIconPath.value.isNotEmpty ? groupIconPath.value : null,
          );

          if (response.status) {
            if (Get.isRegistered<TraderDashboardViewModel>()) {
              Get.find<TraderDashboardViewModel>().fetchDashboardData();
            }
            Get.back();
            Get.snackbar(
              'Success',
              response.message,
              backgroundColor: Colors.green.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
          } else {
            showError(response.message);
          }
        }
      } on ApiException catch (e) {
        showError(e.message);
      } catch (e) {
        showError('Failed to create group. Please try again.');
        debugPrint('Create group error: $e');
      }
    });
  }

  @override
  void onClose() {
    groupNameController.dispose();
    priceController.dispose();
    maximumMembersController.dispose();
    descriptionController.dispose();
    trialDaysController.dispose();
    super.onClose();
  }
}
