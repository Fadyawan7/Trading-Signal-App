import 'package:get/get.dart';

import '../viewmodel/group_chat_view_model.dart';

class GroupChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupChatViewModel>(() => GroupChatViewModel());
  }
}
