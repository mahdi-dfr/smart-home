import 'package:isar/isar.dart';
part 'sensor_config.g.dart';

@collection
class SensorConfig {
  Id isarId = Isar.autoIncrement;
  String? sensorName;
  String? configType;
  int? configRange;
  String? keyName;
  bool? status;

  SensorConfig(this.configType, this.configRange, this.keyName,
      this.status, this.sensorName);
}