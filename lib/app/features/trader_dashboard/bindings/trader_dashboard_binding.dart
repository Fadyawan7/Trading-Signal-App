import 'package:get/get.dart';

import '../viewmodel/trader_dashboard_view_model.dart';

class TraderDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraderDashboardViewModel>(() => TraderDashboardViewModel());
  }
}
