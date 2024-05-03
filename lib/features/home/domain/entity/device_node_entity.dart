import 'package:turkeysh_smart_home/features/home/data/model/device.dart';

class DeviceNodeEntity {
  int? id;
  int? boardProject;
  int? uniqueId;
  bool? isActive;
  int? nodeType;
  int? project;

  DeviceNodeEntity(
      {this.id,
        this.boardProject,
        this.uniqueId,
        this.isActive,
        this.nodeType,
        this.project});
}