import 'package:get/get.dart';

import '../viewmodel/settings_view_model.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsViewModel>(() => SettingsViewModel());
  }
}
