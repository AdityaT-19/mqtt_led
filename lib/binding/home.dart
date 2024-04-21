import 'package:get/get.dart';
import 'package:mqtt_led/controller/home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
