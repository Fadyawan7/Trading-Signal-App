import 'package:get/get.dart';

import '../viewmodel/register_view_model.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterViewModel>(() => RegisterViewModel());
  }
}
