import 'package:get/get.dart';

import '../viewmodel/role_selection_view_model.dart';

class RoleSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleSelectionViewModel>(() => RoleSelectionViewModel());
  }
}
