import 'package:get/get.dart';

import '../../../../core/services/session_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../viewmodel/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(
      () => LoginViewModel(
        authRepository: Get.find<AuthRepository>(),
        sessionService: Get.find<SessionService>(),
      ),
    );
  }
}
