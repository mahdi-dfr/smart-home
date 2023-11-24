import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/connection_controller.dart';
import 'package:turkeysh_smart_home/features/auth/data/repository/auth_repository_impl.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/controller/register_controller.dart';
import 'package:turkeysh_smart_home/features/home/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_helper_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/room_controller.dart';
import 'package:turkeysh_smart_home/features/project/data/repository/project_repository_impl.dart';
import 'package:turkeysh_smart_home/features/project/domain/repository/project_repository.dart';
import 'package:turkeysh_smart_home/features/project/domain/usecase/project_usecase.dart';
import 'package:turkeysh_smart_home/features/project/presentation/controller/project_controller.dart';
import 'package:turkeysh_smart_home/features/settings/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/settings/domain/repository/project_board_repository.dart';
import 'package:turkeysh_smart_home/features/settings/domain/usecase/project_board_usecase.dart';
import 'package:turkeysh_smart_home/features/settings/presentation/controller/project_board_controller.dart';

import '../../features/auth/data/data_source/api_provider.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecase/auth_usecase.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/usecase/device_usecase.dart';
import '../../features/home/domain/usecase/room_usecase.dart';
import '../../features/project/data/data_source/api_provider.dart';
import '../../features/settings/data/repository/project_board_repository_impl.dart';
import '../../test.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {

    /// api providers:
    Get.put<AuthApiProvider>(AuthApiProvider());
    /// repositories:
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find<AuthApiProvider>()));
    ///useCase:
    Get.put<AuthUseCase>(AuthUseCase(Get.find<AuthRepository>()));
    /// controllers:
    Get.put(ConnectionController());
    Get.put(RegisterController(Get.find<AuthUseCase>()));
    //Get.put(MqttService());
  }
}

class ProjectBindings extends Bindings{

  @override
  void dependencies() {

    /// api providers:
    Get.put<ProjectApiProvider>(ProjectApiProvider());
    Get.put<HomeApiProvider>(HomeApiProvider());
    /// repositories:
    Get.put<ProjectRepository>(ProjectRepositoryImpl(Get.find<ProjectApiProvider>()));
    Get.put<HomeRepository>(HomeRepositoryImpl(Get.find<HomeApiProvider>()));
    ///useCase:
    Get.put<ProjectUseCase>(ProjectUseCase(Get.find<ProjectRepository>()));
    Get.put<RoomUseCase>(RoomUseCase(Get.find<HomeRepository>()));
    Get.put<DeviceUseCae>(DeviceUseCae(Get.find<HomeRepository>()));
    /// controllers:
    Get.put(ProjectController(Get.find<ProjectUseCase>()));
    Get.put(RoomController(Get.find<RoomUseCase>()));
    Get.put(DeviceController(Get.find<DeviceUseCae>()));
    Get.put(DeviceHelperController());
  }
}

class SettingsBindings extends Bindings{

  @override
  void dependencies() {
    /// api providers:
    Get.put<ProjectBoardApiProvider>(ProjectBoardApiProvider());
    /// repositories:
    Get.put<ProjectBoardRepository>(ProjectBoardRepositoryImpl(Get.find<ProjectBoardApiProvider>()));
    ///useCase:
    Get.put<ProjectBoardUseCase>(ProjectBoardUseCase(Get.find<ProjectBoardRepository>()));
    /// controllers:
    Get.put(ProjectBoardController(Get.find<ProjectBoardUseCase>()));

  }
}