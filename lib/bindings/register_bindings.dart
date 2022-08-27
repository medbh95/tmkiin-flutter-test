import 'package:get/get.dart';
import 'package:tmkiin_test/controller/register_controller.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
