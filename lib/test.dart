
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService extends GetxController{
  late MqttServerClient client;

  @override
  onInit() async {
    await initializeMqtt();
    //subscribeMessage();
    super.onInit();
  }

  initializeMqtt() async {
    client = MqttServerClient.withPort('remote-asiatech.runflare.com', 'milad', 31809);
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
        .authenticateAs('test', 'sqfgE215WdWIt#YLciNo')
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
    client.subscribe(topic, MqttQos.atMostOnce);
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
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print(
          'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $pt');

      if(topic.contains('')){

      }

    });

  }

  void publishMessage(String message) {
    const pubTopic = 'test/1';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('aaaaaa');
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
}
