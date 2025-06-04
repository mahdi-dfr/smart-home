import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/sensor_config.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';
import 'package:turkeysh_smart_home/features/project/domain/entity/prooject_result_entity.dart';

class IsarController {
  static final IsarController _instance = IsarController._internal();
  static Isar? _isar;

  factory IsarController() {
    return _instance;
  }

  IsarController._internal();

  Isar get isar => _isar!;

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

