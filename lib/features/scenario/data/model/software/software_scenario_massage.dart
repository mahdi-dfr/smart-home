import '../../../domain/entity/software/software_message_entity.dart';

class SoftwareMessageModel extends SoftwareMessageEntity {
  String? type;
  String? scenarioId;
  int? totalBoardIdsUsed;
  String? nodeIds;
  bool? status;

  SoftwareMessageModel(
      {this.type,
      this.scenarioId,
      this.totalBoardIdsUsed,
      this.nodeIds,
      this.status})
      : super(
          type: type,
          scenarioId: scenarioId,
          totalBoardIdsUsed: totalBoardIdsUsed,
          nodeIds: nodeIds,
          status: status,
        );

  SoftwareMessageModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    scenarioId = json['scenario_id'];
    totalBoardIdsUsed = json['total_board_ids_used'];
    nodeIds = json['node_ids'];
    status = json['status'];
  }
}
