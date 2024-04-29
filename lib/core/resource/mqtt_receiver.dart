import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';

import '../../features/settings/domain/entity/project_board_entity.dart';
import '../../features/settings/domain/entity/project_board_resault.dart';
import '../../features/settings/domain/usecase/project_board_usecase.dart';
import '../../mqtt_service.dart';
import 'connection_controller.dart';
import 'data_state.dart';

class MqttReceiver extends GetxController {
  ProjectBoardUseCase _useCase;

  MqttReceiver(this._useCase);

  final _mqttController = Get.find<MqttService>();
  RxList<ProjectBoardResultsEntity>? boardList = RxList();
  String projectName = GetStorage().read(AppUtils.projectNameConst);
  String projectId = GetStorage().read(AppUtils.projectIdConst).toString();
  String username = GetStorage().read(AppUtils.username);
  var relayOneTime1 = ''.obs;
  List<ProjectBoardResultsEntity> relayList = [];
  int? relayCount;

  @override
  onInit() async {
    super.onInit();
    String relayTopic = '$projectName/$username/relay_refresh';
    getAllProjectsBoardsForMessage('1', projectId).then((value) {
      boardList?.value.forEach((element) {
        if (element.boardType == 4) {
          relayList.add(element);
        }
      });
      relayCount = relayList.length;
      if (relayCount! > 0) {
        _mqttController.publishMessage(
            {'type': 'relay_refresh', 'relay_nums': relayCount}, relayTopic);
      }
    });
  }

  Future<DataState<ProjectBoardEntity>> getAllProjectsBoardsForMessage(
      String page, String projectId) async {
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<ProjectBoardEntity> dataState =
          await _useCase.getAllProjectsBoard(page, projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          boardList?.value.addAll(dataState.data!.results ?? []);
        }
        return DataSuccess(dataState.data);
      } else {
        return const DataFailed('err');
      }
    } else {
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }
}
