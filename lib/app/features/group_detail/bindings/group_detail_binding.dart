import 'package:get/get.dart';

import '../viewmodel/group_detail_view_model.dart';

class GroupDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupDetailViewModel>(() => GroupDetailViewModel());
  }
}
