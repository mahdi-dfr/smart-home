import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turkeysh_smart_home/features/project/domain/entity/prooject_result_entity.dart';

class IsarController {
  Isar? _isar;

  Isar get isar => _isar!;

  IsarController(){
    isarInitializer();
  }

  isarInitializer() async {
    if(_isar == null){
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([
        ProjectResultsEntitySchema,
      ], directory: dir.path, relaxedDurability: true);
      return _isar;
    }else{
      return _isar;
    }
  }
}