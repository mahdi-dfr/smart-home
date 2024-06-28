import 'package:turkeysh_smart_home/features/device/data/model/device.dart';

class DeviceNodeEntity {
  int? id;
  // int? boardProject;
  List<dynamic>? boardProject;
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