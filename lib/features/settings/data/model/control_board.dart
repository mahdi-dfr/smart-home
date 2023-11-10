import 'package:turkeysh_smart_home/features/settings/data/model/project_board.dart';

import '../../domain/entity/control_board_entity.dart';

class ControlBoard extends ControlBoardEntity {
  List<ProjectBoardResults>? sms;
  List<ProjectBoardResults>? wifi;

  ControlBoard({this.sms, this.wifi}) : super(sms: sms, wifi: wifi);

  ControlBoard.fromJson(Map<String, dynamic> json) {
    if (json['sms'] != null) {
      sms = <ProjectBoardResults>[];
      json['sms'].forEach((v) {
        sms!.add(ProjectBoardResults.fromJson(v));
      });
    }
    if (json['wifi'] != null) {
      wifi = <ProjectBoardResults>[];
      json['wifi'].forEach((v) {
        wifi!.add(ProjectBoardResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sms != null) {
      data['sms'] = sms!.map((v) => v.toJson()).toList();
    }
    if (wifi != null) {
      data['wifi'] = wifi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
