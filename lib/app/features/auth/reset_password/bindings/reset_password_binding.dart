import 'package:get/get.dart';

import '../../domain/repositories/auth_repository.dart';
import '../viewmodel/reset_password_view_model.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordViewModel>(
      () => ResetPasswordViewModel(authRepository: Get.find<AuthRepository>()),
    );
  }
}
