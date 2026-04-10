import 'package:get/get.dart';

import '../viewmodel/explore_view_model.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreViewModel>(() => ExploreViewModel());
  }
}
