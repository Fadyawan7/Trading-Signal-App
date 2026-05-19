import 'package:get/get.dart';

import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../../trader_dashboard/viewmodel/trader_dashboard_view_model.dart';
import '../../trader_subscription/viewmodel/trader_subscription_view_model.dart';
import '../viewmodel/home_view_model.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
    Get.lazyPut<TraderSubscriptionViewModel>(
      () => TraderSubscriptionViewModel(
        traderRepository: Get.find<TraderRepository>(),
      ),
    );
    Get.lazyPut<TraderDashboardViewModel>(() => TraderDashboardViewModel());
  }
}

