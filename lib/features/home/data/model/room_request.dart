class RoomRequestModel {
  String? name;
  int? project;

  RoomRequestModel({this.name, this.project});

  RoomRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['project'] = project;
    return data;
  }
}
