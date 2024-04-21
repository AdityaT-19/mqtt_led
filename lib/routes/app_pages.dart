import 'package:get/get.dart';
import 'package:mqtt_led/binding/home.dart';
import 'package:mqtt_led/routes/app_routes.dart';
import 'package:mqtt_led/views/home.dart';

class AppPages {
  static const INITIAL = AppRoutes.home;
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => Home(),
      binding: HomeBinding(),
    ),
  ];
}
