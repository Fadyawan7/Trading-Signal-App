import 'package:get/get.dart';

import '../../../../core/services/device_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../viewmodel/register_view_model.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterViewModel>(
      () => RegisterViewModel(
        authRepository: Get.find<AuthRepository>(),
        deviceService: Get.find<DeviceService>(),
      ),
    );
  }
}
