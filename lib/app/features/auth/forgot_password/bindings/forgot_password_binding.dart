import 'package:get/get.dart';

import '../../domain/repositories/auth_repository.dart';
import '../viewmodel/forgot_password_view_model.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(authRepository: Get.find<AuthRepository>()),
    );
  }
}
