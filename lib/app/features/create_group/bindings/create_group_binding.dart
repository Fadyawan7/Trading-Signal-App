import 'package:get/get.dart';

import '../viewmodel/create_group_view_model.dart';

class CreateGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGroupViewModel>(() => CreateGroupViewModel());
  }
}
