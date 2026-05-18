import 'package:get/get.dart';

import '../../../core/services/session_service.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../viewmodel/apply_trader_view_model.dart';

class ApplyTraderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyTraderViewModel>(
      () => ApplyTraderViewModel(
        traderRepository: Get.find<TraderRepository>(),
        sessionService: Get.find<SessionService>(),
      ),
    );
  }
}

