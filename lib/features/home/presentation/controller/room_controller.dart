import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/home/data/model/room_request.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_response_entity.dart';

import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/room_entity.dart';
import '../../domain/usecase/room_usecase.dart';

class RoomController extends GetxController {
  final RoomUseCase _useCase;

  RoomController(this._useCase);

  late TextEditingController roomName;
  RxList<RoomEntity> roomsList = RxList();

  var isLoading = false.obs;
  var isDeleteLoading = false.obs;
  bool isRoomUpdateMode = false;
  int? roomId;
  late Map<String, dynamic> request;

  @override
  void onInit() {
    roomName = TextEditingController();
    getAllRooms(GetStorage().read(AppUtils.projectIdConst));
    super.onInit();
  }

  Future<DataState<String>> createNewRoom(int projectId) async {
    isLoading.value = true;
    request = RoomRequestModel(name: roomName.text, project: projectId).toJson();
    if (Get.find<ConnectionController>().isConnected.value) {
      if (roomName.text.isNotEmpty) {
        DataState dataState = await _useCase.addRoom(request);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            getAllRooms(GetStorage().read(AppUtils.projectIdConst));
            //roomsList.add(dataState.data);
            roomName.text = '';
            isLoading.value = false;
            return const DataSuccess('اطلاعات با موفقیت ذخیره شد');
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
        return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  Future<void> getAllRooms(int projectId) async {
    isLoading.value = true;
    bool offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;

    if (offlineMode) {
      DataState<List<RoomEntity>> localData = await _useCase.getLocalRoom(projectId);
      if (localData is DataSuccess) {
        isLoading.value = false;
        roomsList.value = localData.data ?? [];
        update();
      }
    }else{
      DataState<RoomResponseEntity> dataState = await _useCase.getAllRooms(projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          roomsList.value = dataState.data?.results ?? [];
          await _useCase.deleteRoomFromLocal(projectId);
          await _useCase.saveRoomToLocal(dataState.data!.results ?? []);
          isLoading.value = false;
          update();
        }
      } else {
        if (kDebugMode) {
          print(dataState.error);
        }
      }
    }

  }

  Future<DataState<RoomResponseEntity>> getOneRooms(int projectId) async {
    isLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<RoomResponseEntity> dataState = await _useCase.getAllRooms(projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          roomsList.value = dataState.data?.results ?? [];
        }
        isLoading.value = false;
        return DataSuccess(dataState.data);
      } else {
        return const DataFailed('err');
      }
    } else {
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }

  Future<DataState<String>> updateRoom(int id, int projectId) async {
    isLoading.value = true;
    request = RoomRequestModel(name: roomName.text, project: projectId).toJson();
    if (Get.find<ConnectionController>().isConnected.value) {
      if (roomName.text.isNotEmpty) {
        DataState dataState = await _useCase.updateRoom(request, id, projectId);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            getAllRooms(projectId);
            roomName.text = '';
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
        return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  Future<DataState<String>> deleteRoom(int id, int projectId) async {
    isDeleteLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState dataState = await _useCase.deleteRoomById(id, projectId);
      if (dataState is DataSuccess) {
        getAllRooms(projectId);
        return const DataSuccess('اتاق با موفقیت حذف شد');
      } else {
        isDeleteLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isDeleteLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  @override
  void dispose() {
    roomName.dispose();
    super.dispose();
  }
}
