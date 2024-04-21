import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqtt_led/controller/home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.connect(),
                  child: const Text('Connect'),
                ),
                ElevatedButton(
                  onPressed: () => controller.disconnect(),
                  child: const Text('Disconnect'),
                ),
              ],
            ),
            Obx(
              () => controller.isLoaded.value
                  ? const CircularProgressIndicator()
                  : controller.isConnected.value
                      ? Switch(
                          value: controller.ledState.value,
                          onChanged: (value) => controller.toggleLed(),
                        )
                      : const Text('Not connected'),
            ),
            InkWell(
              onTap: () => controller.changeLedColor(),
              child: Obx(
                () => controller.isConnected.value
                    ? controller.ledState.value
                        ? Obx(() => Container(
                              height: 200,
                              width: 200,
                              color: controller.ledColor.value
                                  ? Colors.green
                                  : Colors.red,
                            ))
                        : Obx(() => Container(
                              height: 200,
                              width: 200,
                              color: controller.ledColor.value
                                  ? Colors.green.withOpacity(0.3)
                                  : Colors.red.withOpacity(0.3),
                            ))
                    : const SizedBox.shrink(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
