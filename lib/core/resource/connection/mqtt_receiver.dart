import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/resource/connection/websocket_service.dart';

import '../../../features/settings/domain/entity/project_board_entity.dart';
import '../../../features/settings/domain/entity/project_board_resault.dart';
import '../../../features/settings/domain/usecase/project_board_usecase.dart';
import 'mqtt_service.dart';
import '../internet_controller.dart';
import '../data_state.dart';

class MqttReceiver extends GetxController {
  final ProjectBoardUseCase _useCase;

  MqttReceiver(this._useCase);

  final _mqttController = Get.find<MqttService>();
  final _websocketController = Get.find<WebsocketService>();
  RxList<ProjectBoardResultsEntity>? boardList = RxList();
  String projectName = GetStorage().read(AppUtils.projectNameConst);
  String projectId = GetStorage().read(AppUtils.projectIdConst).toString();
  String username = GetStorage().read(AppUtils.username);
  bool offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;
  var relayOneTime1 = ''.obs;
  List<ProjectBoardResultsEntity> relayList = [];
  int? relayCount;

  @override
  onInit() async {
    super.onInit();
    String relayTopic = '$projectName/$username/relay_refresh';
    getAllProjectsBoardsForMessage('1', projectId).then((value) {
      boardList?.forEach((element) {
        if (element.boardType == 4) {
          relayList.add(element);
        }
      });
      relayCount = relayList.length;
      if (relayCount! > 0) {
        GetStorage().write(AppUtils.relayCount, relayCount);
        if(offlineMode){
          _websocketController.sendLocalMessage({'type': 'relay_refresh', 'relay_nums': relayCount}, relayTopic);
        }else{
          _mqttController.publishMessage(
              {'type': 'relay_refresh', 'relay_nums': relayCount}, relayTopic);
        }
      }
    });
  }

  Future<DataState<ProjectBoardEntity>> getAllProjectsBoardsForMessage(
      String page, String projectId) async {
    if (Get.find<InternetController>().isConnected.value) {
      DataState<ProjectBoardEntity> dataState =
          await _useCase.getAllProjectsBoard(page, projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          boardList?.addAll(dataState.data!.results ?? []);
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
