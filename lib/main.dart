import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqtt_led/routes/app_pages.dart';
import 'package:mqtt_led/util/mqtt.dart';

void main() {
  MQTTManager.instance.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
    );
  }
}
