import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class IsarController {
  Isar? _isar;

  Isar get getIsar => _isar!;

  IsarController() {
    isarInitializer();
  }

  isarInitializer() async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([

      ], directory: dir.path, relaxedDurability: true);
      return _isar;
    } else {
      return _isar;
    }
  }
}
