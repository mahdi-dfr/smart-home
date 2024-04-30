import '../../../domain/entity/hardware/hardware_message_entity.dart';

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
}

class CreateHardwareScenarioModel {
  int? id;

  CreateHardwareScenarioModel(
      {this.id,});

  CreateHardwareScenarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}


