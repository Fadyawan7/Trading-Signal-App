import 'package:get/get.dart';

import '../../../../core/services/session_service.dart';
import '../viewmodel/role_selection_view_model.dart';

class RoleSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleSelectionViewModel>(
      () => RoleSelectionViewModel(
        sessionService: Get.find<SessionService>(),
      ),
    );
  }
}
