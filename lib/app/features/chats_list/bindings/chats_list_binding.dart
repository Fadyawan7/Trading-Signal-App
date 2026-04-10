import 'package:get/get.dart';

import '../viewmodel/chats_list_view_model.dart';

class ChatsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsListViewModel>(() => ChatsListViewModel());
  }
}
