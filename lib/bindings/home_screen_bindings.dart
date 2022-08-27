import 'package:get/get.dart';
import 'package:tmkiin_test/controller/mainview_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainViewController>(
      () => MainViewController(),
    );
  }
}
