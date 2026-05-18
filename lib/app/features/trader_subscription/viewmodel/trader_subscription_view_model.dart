import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';

import '../../apply_trader/data/models/subscription_plan.dart';
import '../../apply_trader/data/models/my_subscription.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';

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
}
