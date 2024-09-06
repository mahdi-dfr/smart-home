import 'dart:convert';

import 'package:get/get.dart';

import '../../../features/device/presentation/controller/relay_data.dart';

class BoardConnectionController extends GetxController{

  List<RelayData> relayDataList = [];


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

}