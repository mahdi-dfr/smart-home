class HardwareScenarioMessageEntity {
  String? type;
  String? keyNum;
  int? totalBoardIds;
  int? totalBoardIdsUsed;
  String? nodeIds;
  bool? status;

  HardwareScenarioMessageEntity(
      {this.type,
      this.keyNum,
      this.totalBoardIds,
      this.totalBoardIdsUsed,
      this.nodeIds,
      this.status});
}
