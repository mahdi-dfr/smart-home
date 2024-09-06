import 'dart:convert';

import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/connection/board_connection_controller.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../constants/url_constant.dart';

class WebsocketService extends GetxController {
  final _connectionController = Get.find<BoardConnectionController>();

  late WebSocketChannel _channel;

  @override
  void onInit() {
    super.onInit();

    _channel = IOWebSocketChannel.connect(UrlConstant.websocketUrl);
  }

  sendLocalMessage(Map<String, dynamic> message, String topic) {
    Map<String, dynamic> messageData = {topic: message};
    _channel.sink.add(json.encode(messageData));
  }

  listenToMessage() {
    _channel.stream.listen((message) {
      _connectionController.setRelayList(message);
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
