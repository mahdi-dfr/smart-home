
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../constants/utils.dart';
import '../../features/device/presentation/controller/relay_data.dart';
import '../../features/home/presentation/controller/relay_controller.dart';

class MqttService extends GetxController{
  late MqttServerClient client;

  String projectName = GetStorage().read(AppUtils.projectNameConst);
  String username = GetStorage().read(AppUtils.username);
  List<RelayData> relayDataList = [];

  @override
  onInit() async {
    await initializeMqtt();
    subscribeMessage('$username/$projectName/relay');
    super.onInit();
  }

  initializeMqtt() async {
    String generateUniqueClientId() {
      const Uuid uuid = Uuid();
      return uuid.v4();
    }
    String uniqueClientId = generateUniqueClientId();
    client = MqttServerClient.withPort('iot.perkyiot.com',uniqueClientId, 30320);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    //client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.logging(on: true);
    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .authenticateAs('mosquitto2', 'gjEZPS71fj2WqwinXIpl')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
    const topic = 'test/1';
    print('Subscribing to the $topic topic');
    client.subscribe(topic, MqttQos.atLeastOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Received message: topic is ${c[0].topic}, payload is $pt');
    });

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('client connected');
    } else {
      print(
          'client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }
  }

  subscribeMessage(String topic) {

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
        setRelayList(payload);
      }

    });

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

  bool parseBinaryMessage(String data ,int index){
    return data[index] == '1' ? true : false;
  }

  setRelayList(String payload){
    final Map<String, dynamic> jsonMessage = json.decode(payload);
    print('.....................');
    print(jsonMessage);

    removeSameMessages(jsonMessage);

    RelayData relayData = RelayData(boardId: jsonMessage['board_id'],
      key1: parseBinaryMessage(jsonMessage['node_status'], 0),
      key2: parseBinaryMessage(jsonMessage['node_status'], 1),
      key3: parseBinaryMessage(jsonMessage['node_status'], 2),
      key4: parseBinaryMessage(jsonMessage['node_status'], 3),
      key5: parseBinaryMessage(jsonMessage['node_status'], 4),
      key6: parseBinaryMessage(jsonMessage['node_status'], 5),
      key7: parseBinaryMessage(jsonMessage['node_status'], 6),
      key8: parseBinaryMessage(jsonMessage['node_status'], 7),
      key9: parseBinaryMessage(jsonMessage['node_status'], 8),
      key10: parseBinaryMessage(jsonMessage['node_status'], 9),
      key11: parseBinaryMessage(jsonMessage['node_status'], 10),
      key12: parseBinaryMessage(jsonMessage['node_status'], 11),
    );

    relayDataList.add(relayData);

    update();
  }

  removeSameMessages(Map<String, dynamic> jsonMessage){
    int elementIndex = -1;
    relayDataList.forEach((element) {
      if(element.boardId == jsonMessage['board_id']){
        elementIndex = relayDataList.indexOf(element);
      }
    });
    if(elementIndex != -1){
      relayDataList.removeAt(elementIndex);
    }
  }

  @override
  void onClose() {
    client.disconnect();
    super.onClose();
  }


}
