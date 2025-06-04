
import 'dart:convert';
import 'package:turkeysh_smart_home/core/resource/connection/board_connection_controller.dart';
import 'package:turkeysh_smart_home/core/resource/internet_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../constants/url_constant.dart';
import '../../constants/utils.dart';
import '../../../features/device/presentation/controller/relay_data.dart';
import '../../../features/home/presentation/controller/relay_controller.dart';


class MqttService extends GetxController {
  late MqttServerClient client;

  final String projectName = GetStorage().read(AppUtils.projectNameConst);
  final String username = GetStorage().read(AppUtils.username);
  final bool isOfflineMode = GetStorage().read(AppUtils.offlineMode) ?? false;

  final connectionController = Get.find<BoardConnectionController>();
  final internetController = Get.find<InternetController>();

  @override
  void onInit() async {
    await initializeMqtt();

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      // سابسکرایب تاپیک‌ها فقط در صورت اتصال موفق
      subscribeToTopic('$username/$projectName/sensor');
      subscribeToTopic('$username/$projectName/relay');

      // فعال کردن لیسنر یک‌بار برای همه پیام‌ها
      _listenToMessages();
    }

    super.onInit();
  }

  Future<void> initializeMqtt() async {
    if (!internetController.isConnected.value || isOfflineMode) return;

    final uniqueClientId = _generateUniqueClientId();
    client = _createMqttClient(uniqueClientId);
    _configureClient();

    try {
      await client.connect();
      _handleConnection();
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  String _generateUniqueClientId() {
    return const Uuid().v4();
  }

  MqttServerClient _createMqttClient(String clientId) {
    final mqttClient = MqttServerClient.withPort(
      UrlConstant.mqttUrl,
      clientId,
      30320,
    );
    mqttClient.logging(on: true);
    return mqttClient;
  }

  void _configureClient() {
    client
      ..onConnected = onConnected
      ..onDisconnected = onDisconnected
      ..onSubscribed = onSubscribed
      ..onSubscribeFail = onSubscribeFail
      ..pongCallback = pong
      ..keepAlivePeriod = 60
      ..setProtocolV311();

    final connMessage = MqttConnectMessage()
        .authenticateAs(UrlConstant.mqttUsername, UrlConstant.mqttPassword)
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMessage;
  }

  void _handleConnection() {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('Client connected');
    } else {
      print('Client connection failed - status: ${client.connectionStatus}');
      client.disconnect();
    }
  }

  void _handleConnectionError(Object error) {
    print('MQTT Exception: $error');
    client.disconnect();
  }

  void subscribeToTopic(String topic) {
    print('MQTT_LOGS:: Subscribing to <$topic>');
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  void _listenToMessages() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
      if (messages == null || messages.isEmpty) return;

      final message = messages.first;
      final topic = message.topic;
      final payloadMessage = message.payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(payloadMessage.payload.message);

      print('MQTT_LOGS:: Message received from <$topic>: $payload');

      // تشخیص نوع برد از روی تاپیک
      if (topic.contains('relay')) {
        connectionController.setRelayList(payload);
      } else if (topic.contains('sensor')) {
        connectionController.setSensorList(payload);
      } else {
        print('Unknown topic received: $topic');
      }
    });
  }

  void publishMessage(Map<String, dynamic> message, String topic) {
    if (client.connectionStatus?.state != MqttConnectionState.connected) return;

    final builder = MqttClientPayloadBuilder();
    builder.addString(json.encode(message));

    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  // Event callbacks
  void onConnected() => print('MQTT Connected');
  void onDisconnected() => print('MQTT Disconnected');
  void onSubscribed(String topic) => print('Subscribed to $topic');
  void onSubscribeFail(String topic) => print('Failed to subscribe $topic');
  void onUnsubscribed(String topic) => print('Unsubscribed from $topic');
  void pong() => print('Ping response received');

  @override
  void onClose() {
    client.disconnect();
    super.onClose();
  }
}


















//
// class MqttService extends GetxController{
//   late MqttServerClient client;
//
//   String projectName = GetStorage().read(AppUtils.projectNameConst);
//   String username = GetStorage().read(AppUtils.username);
//   bool isOfflineMode = GetStorage().read(AppUtils.offlineMode) ?? false;
//   final connectionController = Get.find<BoardConnectionController>();
//
//   @override
//   onInit() async {
//     await initializeMqtt();
//     subscribeMessage('$username/$projectName/sensor');
//     subscribeMessage('$username/$projectName/relay');
//     _listenToMessages();
//
//     super.onInit();
//   }
//
//   Future<void> initializeMqtt() async {
//     final connectionController = Get.find<InternetController>();
//
//     if (connectionController.isConnected.value) {
//       final uniqueClientId = _generateUniqueClientId();
//       client = _createMqttClient(uniqueClientId);
//
//       _configureClient();
//
//       try {
//         await client.connect();
//         _handleConnection();
//         //_subscribeToTopic('test/1');
//         //_listenToMessages();
//       } catch (e) {
//         _handleConnectionError(e);
//       }
//     }
//   }
//
//   String _generateUniqueClientId() {
//     const Uuid uuid = Uuid();
//     return uuid.v4();
//   }
//
//   MqttServerClient _createMqttClient(String clientId) {
//     final MqttServerClient mqttClient = MqttServerClient.withPort(UrlConstant.mqttUrl, clientId, 30320);
//     mqttClient.logging(on: true);
//     return mqttClient;
//   }
//
//   void _configureClient() {
//     client.onConnected = onConnected;
//     client.onDisconnected = onDisconnected;
//     client.onSubscribed = onSubscribed;
//     client.onSubscribeFail = onSubscribeFail;
//     client.pongCallback = pong;
//     client.keepAlivePeriod = 60;
//     client.setProtocolV311();
//
//     final connMessage = MqttConnectMessage()
//         .authenticateAs(UrlConstant.mqttUsername, UrlConstant.mqttPassword)
//         .keepAliveFor(60)
//         .withWillTopic('willtopic')
//         .withWillMessage('Will message')
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce);
//
//     client.connectionMessage = connMessage;
//   }
//
//   void _handleConnection() {
//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       print('Client connected');
//     } else {
//       print('Client connection failed - status is ${client.connectionStatus}');
//       client.disconnect();
//     }
//   }
//
//   void _subscribeToTopic(String topic) {
//     print('Subscribing to the $topic topic');
//     client.subscribe(topic, MqttQos.atLeastOnce);
//   }
//
//   // void _listenToMessages() {
//   //   client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
//   //     final recMess = messages![0].payload as MqttPublishMessage;
//   //     final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//   //     print('Received message: topic is ${messages[0].topic}, payload is $payload');
//   //
//   //     // if(messages[0].topic.contains('relay')){
//   //     //   print('///////..');
//   //     //   connectionController.setRelayList(payload);
//   //     // }else{
//   //     //   print('iiiiii');
//   //     //   connectionController.setSensorList(payload);
//   //     // }
//   //   });
//   // }
//
//
//   void _listenToMessages() {
//     client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
//       final recMess = messages![0].payload as MqttPublishMessage;
//       final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//       final topic = messages[0].topic;
//
//       print('Received message: topic is <$topic>, payload is <$payload>');
//
//       // هندل کردن بر اساس تاپیک واقعی پیام
//       if (topic.contains('relay')) {
//         connectionController.setRelayList(payload);
//       } else if (topic.contains('sensor')) {
//         connectionController.setSensorList(payload);
//       } else {
//         print('Unknown topic: $topic');
//       }
//     });
//   }
//
//
//
//   void _handleConnectionError(Object error) {
//     print('Exception: $error');
//     client.disconnect();
//   }
//
//   void subscribeMessage(String topic) {
//     if (Get.find<InternetController>().isConnected.value && !isOfflineMode) {
//       print('MQTT_LOGS::Subscribing to topic <$topic>');
//       client.subscribe(topic, MqttQos.atMostOnce);
//     }
//   }
//
//
//   //
//   // subscribeMessage(String topic) {
//   //   if(Get.find<InternetController>().isConnected.value && !isOfflineMode){
//   //     print('MQTT_LOGS::Subscribing to the test/lol topic');
//   //     client.subscribe(topic, MqttQos.atMostOnce);
//   //
//   //     client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
//   //       final recMess = c![0].payload as MqttPublishMessage;
//   //       final payload =
//   //       MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//   //
//   //       print(
//   //           'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $payload');
//   //
//   //
//   //       if(topic.contains('relay')){
//   //         print('///////..');
//   //         print(topic);
//   //         connectionController.setRelayList(payload);
//   //       }else{
//   //         print('iiiiiiiiii');
//   //         print(topic);
//   //         connectionController.setSensorList(payload);
//   //       }
//   //
//   //     });
//   //   }
//   //
//   // }
//
//   void publishMessage(Map<String, dynamic> message, String topic) {
//     String pubTopic = topic;
//     final builder = MqttClientPayloadBuilder();
//     builder.addString(
//       json.encode(message)
//     );
//
//     if (client.connectionStatus?.state == MqttConnectionState.connected) {
//       client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
//     }
//   }
//
//   void onConnected() {
//     print('Connected');
//   }
//
//   void onDisconnected() {
//     print('Disconnected');
//   }
//
//   void onSubscribed(String topic) {
//     print('Subscribed topic: $topic');
//   }
//
//   void onSubscribeFail(String topic) {
//     print('Failed to subscribe $topic');
//   }
//
//   void onUnsubscribed(String topic) {
//     print('Unsubscribed topic: $topic');
//   }
//
//   void pong() {
//     print('Ping response client callback invoked');
//   }
//
//
//
//   @override
//   void onClose() {
//     client.disconnect();
//     super.onClose();
//   }
//
//
// }
