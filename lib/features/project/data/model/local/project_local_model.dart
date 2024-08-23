import 'package:isar/isar.dart';
part 'project_local_model.g.dart';

@collection
class ProjectLocal{
  Id id = Isar.autoIncrement;
  String? name;
  String? address;
  String? createdAt;
  String? deleteAt;
  int? user;

  ProjectLocal(this.name, this.address, this.createdAt, this.deleteAt, this.user);
}