import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/services/session_service.dart';
import '../../../routes/app_routes.dart';

import '../../apply_trader/data/models/subscription_plan.dart';
import '../../apply_trader/data/models/my_subscription.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';

class TraderSubscriptionViewModel extends BaseViewModel {
  TraderSubscriptionViewModel({
    required TraderRepository traderRepository,
  })  : _traderRepository = traderRepository;

  final TraderRepository _traderRepository;


  final title = 'Choose Your Plan';
  final subtitle = 'Choose a plan that fits your needs. Upgrade or downgrade anytime.';

  // State Observables
  final plans = <SubscriptionPlan>[].obs;
  final mySubscriptions = <MySubscription>[].obs;
  
  // Selection States
  final selectedPlanId = RxnInt();
  final billingCycle = 'weekly'.obs; // Supportweekly, monthly, yearly

  @override
  void onInit() {
    super.onInit();
    // Default load
    fetchSubscriptionPlans();
    fetchMySubscriptions();
  }

  // Fetch subscription plans
  Future<void> fetchSubscriptionPlans() async {
    plans.clear();
    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.getSubscriptionPlans(
            type: billingCycle.value,
          );
          if (response.status) {
            plans.assignAll(response.plans);
          } else {
            showError(response.message);
          }
        }
      } on ApiException catch (error) {
        showError(error.message);
      } catch (e) {
        showError('Failed to load subscription plans.');
      }
    });
  }

  // Change billing cycle and reload plans
  void setBillingCycle(String cycle) {
    if (billingCycle.value != cycle) {
      billingCycle.value = cycle;
      fetchSubscriptionPlans();
    }
  }

  // Fetch active subscriptions
  Future<void> fetchMySubscriptions() async {
    mySubscriptions.clear();
    try {
      if (ensureInternetConnection()) {
        final response = await _traderRepository.getMySubscriptions();
        if (response.status) {
          mySubscriptions.assignAll(response.subscriptions);
        }
      }
    } catch (e) {
      debugPrint('Failed to load active subscriptions: $e');
    }
  }

  // Direct purchase method bypasses payment screen
  Future<void> buySubscriptionPlan(int planId) async {
    bool isSuccess = false;
    String? successMessage;

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.buySubscriptionPlan(
            planId: planId.toString(),
          );
          isSuccess = response.status;
          successMessage = response.message;

          if (isSuccess) {
            // Immediately sync updated user roles and subscription statuses
            try {
              final profileRepository = Get.find<ProfileRepository>();
              final sessionService = Get.find<SessionService>();
              final rolesResponse = await profileRepository.getUserRoles();
              if (rolesResponse.status && rolesResponse.data != null) {
                final data = rolesResponse.data!;
                final roles = data.roles.map((e) => e.name).toList();
                await sessionService.saveRolesData(
                  roles: roles,
                  traderStatus: data.traderStatus,
                  isSubscription: data.isSubscription,
                );
              }
            } catch (e) {
              debugPrint('Error updating roles after purchase: $e');
            }
          }
        }
      } on ApiException catch (error) {
        showError(error.message);
      } catch (e) {
        showError('Failed to purchase subscription. Please try again.');
      }
    });

    if (isSuccess) {
      showSuccess(successMessage ?? 'Subscription purchased successfully');
      // Redirect back to home screen where the Trader Dashboard will render reactively
      Get.offAllNamed(AppRoutes.home);
    }
  }
}

