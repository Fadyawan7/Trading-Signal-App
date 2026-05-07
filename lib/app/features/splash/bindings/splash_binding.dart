import 'package:get/get.dart';

import '../../../core/services/session_service.dart';
import '../viewmodel/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(sessionService: Get.find<SessionService>()),
    );
  }
}
