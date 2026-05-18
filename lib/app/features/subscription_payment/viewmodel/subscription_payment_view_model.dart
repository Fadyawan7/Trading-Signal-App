import 'package:get/get.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/network/api_exception.dart';
import '../../../routes/app_routes.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';

class SubscriptionPaymentViewModel extends BaseViewModel {
  SubscriptionPaymentViewModel({
    required TraderRepository traderRepository,
  })  : _traderRepository = traderRepository;

  final TraderRepository _traderRepository;


  final title = 'Subscription Payment';
  final subtitle = 'Complete payment for your selected plan tier.';
  final cta = 'Pay Subscription';

  Future<void> purchaseSubscription(String planId) async {
    if (planId.isEmpty) {
      showError('Plan ID is missing. Please go back and select a plan again.');
      return;
    }

    bool isSuccess = false;
    String? successMessage;

    await runWithLoading(() async {
      try {
        if (ensureInternetConnection()) {
          final response = await _traderRepository.buySubscriptionPlan(
            planId: planId,
          );
          isSuccess = response.status;
          successMessage = response.message;
        }
      } on ApiException catch (error) {
        showError(error.message);
      } catch (e) {
        showError('Failed to purchase subscription. Please try again.');
      }
    });

    if (isSuccess) {
      showSuccess(successMessage ?? 'Subscription purchased successfully');
      // Redirect to trader dashboard
      Get.offAllNamed(AppRoutes.traderDashboard);
    }
  }
}
