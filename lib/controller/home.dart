import 'package:get/get.dart';
import 'package:mqtt_led/util/const.dart';
import 'package:mqtt_led/util/mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';

class HomeController extends GetxController {
  RxBool isConnected = false.obs;
  RxBool isLoaded = false.obs;
  RxBool ledState = false.obs;
  bool state = false;
  RxBool ledColor = false.obs;
  bool color = false;

  final manager = MQTTManager.instance;

  void connect() async {
    isLoaded.value = true;
    await manager.connect();
    subsribeToLedToggle();
    subsribeToLedColor();
    isConnected.value = manager.isConnected;

    isLoaded.value = false;
  }

  void disconnect() {
    manager.disconnect();
    isConnected.value = manager.isConnected;
  }

  void toggleLed() {
    state = !state;
    manager.publishMessage('toggle', state ? 'on' : 'off');
  }

  void changeLedColor() {
    color = !color;
    manager.publishMessage('change', color ? 'green' : 'red');
  }

  void subsribeToLedToggle() {
    manager.client.subscribe('${mqttTopic}toggle', MqttQos.atLeastOnce);
    manager.client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      if (pt == 'on') {
        ledState.value = true;
      } else {
        ledState.value = false;
      }
    });
  }

  void subsribeToLedColor() {
    manager.client.subscribe('${mqttTopic}change', MqttQos.atLeastOnce);
    manager.client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      if (pt == 'green') {
        state = false;
        ledState.value = false;
        ledColor.value = true;
      } else if (pt == 'red') {
        state = false;
        ledState.value = false;
        ledColor.value = false;
      }
    });
  }
}
