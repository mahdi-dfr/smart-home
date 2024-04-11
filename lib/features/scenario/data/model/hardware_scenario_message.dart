import '../../domain/entity/hardware_message_entity.dart';

class HardwareScenarioMessage extends HardwareScenarioMessageEntity {
  String? type;
  String? keyNum;
  int? totalBoardIds;
  int? totalBoardIdsUsed;
  String? nodeIds;
  bool? status;

  HardwareScenarioMessage(
      {this.type,
      this.keyNum,
      this.totalBoardIds,
      this.totalBoardIdsUsed,
      this.nodeIds,
      this.status})
      : super(
          type: type,
          keyNum: keyNum,
          totalBoardIds: totalBoardIds,
          totalBoardIdsUsed: totalBoardIdsUsed,
          nodeIds: nodeIds,
          status: status,
        );

  HardwareScenarioMessage.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    keyNum = json['key_num'];
    totalBoardIds = json['total_board_ids'];
    totalBoardIdsUsed = json['total_board_ids_used'];
    nodeIds = json['node_ids'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['key_num'] = keyNum;
    data['total_board_ids'] = totalBoardIds;
    data['total_board_ids_used'] = totalBoardIdsUsed;
    data['node_ids'] = nodeIds;
    data['status'] = status;
    return data;
  }
}

class CreateHardwareScenarioModel {
  int? id;

  CreateHardwareScenarioModel(
      {this.id,});

  CreateHardwareScenarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}


