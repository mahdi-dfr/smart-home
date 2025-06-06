import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/device/domain/entity/device_entity.dart';
import '../../features/device/domain/entity/sensor_config.dart';
import '../../features/home/domain/entity/room_entity.dart';
import '../../features/project/domain/entity/prooject_result_entity.dart';


class IsarController {
  static Isar? _isar;

  Isar get isar => _isar!;

  IsarController() {
    isarInitializer();
  }

  Future<void> isarInitializer() async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([
      ProjectResultsEntitySchema,
      RoomEntitySchema,
      DeviceEntitySchema,
      SensorConfigSchema,
      ], directory: dir.path, relaxedDurability: true);
    }
  }
}
