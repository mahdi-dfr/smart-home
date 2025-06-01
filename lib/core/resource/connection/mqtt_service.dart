
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

class MqttService extends GetxController{
  late MqttServerClient client;

  String projectName = GetStorage().read(AppUtils.projectNameConst);
  String username = GetStorage().read(AppUtils.username);
  bool isOfflineMode = GetStorage().read(AppUtils.offlineMode);
  final connectionController = Get.find<BoardConnectionController>();

  @override
  onInit() async {
    await initializeMqtt();
    subscribeMessage('$username/$projectName/relay');
    super.onInit();
  }

  Future<void> initializeMqtt() async {
    final connectionController = Get.find<InternetController>();

    if (connectionController.isConnected.value) {
      final uniqueClientId = _generateUniqueClientId();
      client = _createMqttClient(uniqueClientId);

      _configureClient();

      try {
        await client.connect();
        _handleConnection();
        _subscribeToTopic('test/1');
        _listenToMessages();
      } catch (e) {
        _handleConnectionError(e);
      }
    }
  }

  String _generateUniqueClientId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  MqttServerClient _createMqttClient(String clientId) {
    final MqttServerClient mqttClient = MqttServerClient.withPort(UrlConstant.mqttUrl, clientId, 30320);
    mqttClient.logging(on: true);
    return mqttClient;
  }

  void _configureClient() {
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.setProtocolV311();

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
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Client connected');
    } else {
      print('Client connection failed - status is ${client.connectionStatus}');
      client.disconnect();
    }
  }

  void _subscribeToTopic(String topic) {
    print('Subscribing to the $topic topic');
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void _listenToMessages() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
      final recMess = messages![0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Received message: topic is ${messages[0].topic}, payload is $payload');
    });
  }

  void _handleConnectionError(Object error) {
    print('Exception: $error');
    client.disconnect();
  }


  subscribeMessage(String topic) {
    if(Get.find<InternetController>().isConnected.value && !isOfflineMode){
      print('MQTT_LOGS::Subscribing to the test/lol topic');
      client.subscribe(topic, MqttQos.atMostOnce);

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final payload =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print(
            'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $payload');


        if(topic.contains('relay')){
          print('///////..');
          connectionController.setRelayList(payload);
        }

      });
    }

  }

  void publishMessage(Map<String, dynamic> message, String topic) {
    String pubTopic = topic;
    final builder = MqttClientPayloadBuilder();
    builder.addString(
      json.encode(message)
    );

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
    }
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }



  @override
  void onClose() {
    client.disconnect();
    super.onClose();
  }


}
