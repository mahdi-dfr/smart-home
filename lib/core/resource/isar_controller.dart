import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';
import 'package:turkeysh_smart_home/features/project/domain/entity/prooject_result_entity.dart';

class IsarController {
  static Isar? _isar;

  Isar get isar => _isar!;

  IsarController(){
    isarInitializer();
  }

  Future<void> isarInitializer() async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([
        ProjectResultsEntitySchema,
        RoomEntitySchema,
        DeviceEntitySchema,
      ], directory: dir.path, relaxedDurability: true);
    }
  }
}
