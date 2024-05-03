class SoftwareMessageEntity {
  String? type;
  int? scenarioId;
  int? totalBoardIdsUsed;
  String? nodeIds;
  bool? status;

  SoftwareMessageEntity({this.type,
    this.scenarioId,
    this.totalBoardIdsUsed,
    this.nodeIds,
    this.status});
}