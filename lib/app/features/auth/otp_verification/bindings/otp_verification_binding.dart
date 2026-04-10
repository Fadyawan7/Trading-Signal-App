import 'package:get/get.dart';

import '../viewmodel/otp_verification_view_model.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationViewModel>(() => OtpVerificationViewModel());
  }
}
