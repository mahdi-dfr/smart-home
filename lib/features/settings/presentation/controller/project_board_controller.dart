import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/settings/domain/entity/control_board_entity.dart';
import 'package:turkeysh_smart_home/features/settings/domain/entity/project_board_entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/project_board_resault.dart';
import '../../domain/usecase/project_board_usecase.dart';

class ProjectBoardController extends GetxController {
  ProjectBoardUseCase _useCase;

  ProjectBoardController(this._useCase);

  final PagingController<int, ProjectBoardResultsEntity> pagingController =
      PagingController(firstPageKey: 1);

  var isLoading = false.obs;
  var isDeleteLoading = false.obs;
  bool isInEditMode = false;
  bool projectEditMode = false;
  int projectId =
      int.parse(GetStorage().read(AppUtils.projectIdConst).toString());
  late TextEditingController boardName;
  RxList<ControlBoardEntity> boardControllerList = RxList();
  RxMap<String, dynamic> smsBoardList = RxMap();
  RxMap<String, dynamic> wifiBoardList = RxMap();

  var isSensorChecked = false.obs;
  var isSMSChecked = false.obs;
  var isWifiChecked = false.obs;
  var isDimmerChecked = false.obs;
  var isRelayChecked = false.obs;
  String? selectedSmsControlBoard;
  String? selectedWifiControlBoard;


  String? selectedBoardType;
  String? boardType;

  @override
  void onInit() {
    boardName = TextEditingController();

    pagingController.addPageRequestListener((pageKey) async {
      await getAllProjectsBoards((pageKey).toString(),
          GetStorage().read(AppUtils.projectIdConst).toString());
    });
    super.onInit();
  }

  Future<DataState<ProjectBoardResultsEntity>> createNewBoardProject() async {
    isLoading.value = true;

    if (boardName.text.isNotEmpty) {

      print('ssssss00');
      print(selectedSmsControlBoard);
      print(selectedWifiControlBoard);

      Map<String, dynamic> data = {
        "name": boardName.text,
        "project": projectId,
        "board_type": selectedBoardType,
        "parent_sms_board": selectedSmsControlBoard,
        "parent_wifi_board": selectedWifiControlBoard
      };
      print(data);
      if (Get.find<ConnectionController>().isConnected.value) {
        DataState dataState = await _useCase.addProjectBoard(data);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            makeCreatePageFieldsClean();
            pagingController.refresh();
            createNewBoardNode(dataState.data.id);
            isLoading.value = false;
            return DataSuccess(dataState.data);
          } else {
            isLoading.value = false;
            return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
          }
        } else {
          isLoading.value = false;
          return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
        }
      } else {
        isLoading.value = false;
        return const DataFailed(
            'لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('لطفا اطلاعات لازم را وارد نمایید');
    }
  }

  Future<DataState<ProjectBoardEntity>> getAllProjectsBoards(
      String page, String projectId) async {
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<ProjectBoardEntity> dataState =
          await _useCase.getAllProjectsBoard(page, projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {

          //boardList?.value.addAll(dataState.data!.results ?? []);
          if (dataState.data?.next != null) {
            pagingController.appendPage(
                dataState.data?.results ?? [], int.parse(page));
          } else {
            pagingController.appendLastPage(dataState.data?.results ?? []);
          }
        }
        return DataSuccess(dataState.data);
      } else {
        return const DataFailed('err');
      }
    } else {
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }

  Future<DataState<String>> updateProject() async {
    isLoading.value = true;

    if (boardName.text.isNotEmpty) {
      Map<String, dynamic> data = {
        "name": boardName.text,
        "project": GetStorage().read(AppUtils.projectIdConst),
        "board_type": selectedBoardType,
        "parent_sms_board": selectedSmsControlBoard,
        "parent_wifi_board": selectedWifiControlBoard
      };
      if (Get.find<ConnectionController>().isConnected.value) {
        DataState dataState =
            await _useCase.updateProjectBoard(data, projectId);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            makeCreatePageFieldsClean();
            pagingController.refresh();
            isLoading.value = false;
            return const DataSuccess('اطلاعات با موفقیت ویرایش شد');
          } else {
            isLoading.value = false;
            return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
          }
        } else {
          isLoading.value = false;
          return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
        }
      } else {
        isLoading.value = false;
        return const DataFailed(
            'لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('لطفا اطلاعات لازم را وارد نمایید');
    }
  }

  Future<DataState<String>> deleteProjectBoard(int id) async {
    isDeleteLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState dataState = await _useCase.deleteProjectBoardById(id);
      if (dataState is DataSuccess) {
        pagingController.refresh();
        return const DataSuccess('برد با موفقیت حذف شد');
      } else {
        isDeleteLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isDeleteLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  Future<DataState<ControlBoardEntity>> getControlBoard(
      String projectId) async {
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<ControlBoardEntity> dataState =
          await _useCase.getControlBoards(projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          dataState.data?.sms?.forEach((element) {
            smsBoardList[element.name ?? ''] = element.id;
          });
          dataState.data?.wifi?.forEach((element) {
            wifiBoardList[element.name ?? ''] = element.id;
          });
        }
        return DataSuccess(dataState.data);
      } else {
        return const DataFailed('err');
      }
    } else {
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }

  Future<DataState<String>> createNewBoardNode(int projectBoard) async {
    Map<String, dynamic> data = {
      "board_project": projectBoard,
      "project": projectId,
    };
    DataState dataState = await _useCase.addProjectNode(data);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        return const DataSuccess('success');
      } else {
        isLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isLoading.value = false;
      return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
    }
  }

  changeBoardCheckValue(String value, bool check) {
    if (check) {
      selectedBoardType = value;
    }
    selectedWifiControlBoard = null;
    selectedSmsControlBoard = null;
  }

  makeCreatePageFieldsClean() {
    boardName.text = '';
    isSensorChecked.value = false;
    isSMSChecked.value = false;
    isWifiChecked.value = false;
    isDimmerChecked.value = false;
    isRelayChecked.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
    boardName.dispose();
  }
}
