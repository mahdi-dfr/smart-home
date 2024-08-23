import 'package:isar/isar.dart';
part 'prooject_result_entity.g.dart';

@collection
class ProjectResultsEntity {
  Id isarId = Isar.autoIncrement;
  int? id;
  String? name;
  String? address;
  String? createdAt;
  String? deleteAt;
  int? user;

  ProjectResultsEntity({
    this.id,
    this.name,
    this.address,
    this.createdAt,
    this.deleteAt,
    this.user});
}