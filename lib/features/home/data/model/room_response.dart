import '../../domain/entity/room_entity.dart';
import '../../domain/entity/room_response_entity.dart';

class RoomResponseModel extends RoomResponseEntity {
  int? count;
  String? next;
  String? previous;
  List<RoomResults>? results;

  RoomResponseModel({this.count, this.next, this.previous, this.results})
      : super(
          count: count,
          next: next,
          previous: previous,
          results: results,
        );

  RoomResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <RoomResults>[];
      json['results'].forEach((v) {
        results!.add(RoomResults.fromJson(v));
      });
    }
  }
}

class RoomResults extends RoomEntity {
  int? id;
  String? name;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? project;

  RoomResults(
      {this.id,
      this.name,
      this.createdAt,
      this.deleteAt,
      this.updateAt,
      this.project})
      : super(
          id: id,
          name: name,
          createdAt: createdAt,
          deleteAt: deleteAt,
          updateAt: updateAt,
          project: project,
        );

  RoomResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    updateAt = json['update_at'];
    project = json['project'];
  }
}
