import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/connection_controller.dart';
import 'package:turkeysh_smart_home/features/auth/data/repository/auth_repository_impl.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/controller/register_controller.dart';
import 'package:turkeysh_smart_home/features/device/domain/repository/device_repository.dart';
import 'package:turkeysh_smart_home/features/home/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_helper_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/room_controller.dart';
import 'package:turkeysh_smart_home/features/project/data/repository/project_repository_impl.dart';
import 'package:turkeysh_smart_home/features/project/domain/repository/project_repository.dart';
import 'package:turkeysh_smart_home/features/project/domain/usecase/project_usecase.dart';
import 'package:turkeysh_smart_home/features/project/presentation/controller/project_controller.dart';
import 'package:turkeysh_smart_home/features/scenario/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/scenario/data/repository/repository_impl.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/usecase/scenario_usecase.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/hardware_scenario_controller.dart';
import 'package:turkeysh_smart_home/features/settings/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/settings/domain/repository/project_board_repository.dart';
import 'package:turkeysh_smart_home/features/settings/domain/usecase/project_board_usecase.dart';
import 'package:turkeysh_smart_home/features/settings/presentation/controller/project_board_controller.dart';

import '../../features/auth/data/data_source/api_provider.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecase/auth_usecase.dart';
import '../../features/device/data/data_source/api_provider.dart';
import '../../features/device/data/repository/device_repository_impl.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/device/domain/usecase/device_usecase.dart';
import '../../features/home/domain/usecase/room_usecase.dart';
import '../../features/home/presentation/controller/relay_controller.dart';
import '../../features/project/data/data_source/api_provider.dart';
import '../../features/scenario/presentation/controller/software_controller.dart';
import '../../features/settings/data/repository/project_board_repository_impl.dart';
import 'isar_controller.dart';
import 'mqtt_service.dart';
import 'mqtt_receiver.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {

    Get.put<IsarController>(IsarController());

    /// api providers:
    Get.put<AuthApiProvider>(AuthApiProvider());
    Get.lazyPut(() => ScenarioApiProvider(), fenix: true);
    /// repositories:
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find<AuthApiProvider>()));
    Get.lazyPut(() => ScenarioRepositoryImpl(Get.find<ScenarioApiProvider>()), fenix: true);
    ///useCase:
    Get.put<AuthUseCase>(AuthUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => ScenarioUseCase(Get.find<ScenarioRepositoryImpl>()), fenix: true);
    /// controllers:
    Get.put(ConnectionController());
    Get.put(RegisterController(Get.find<AuthUseCase>()));
    Get.lazyPut(() => HardwareScenarioController(Get.find<ScenarioUseCase>()), fenix: true);
    Get.lazyPut(() => SoftwareScenarioController(Get.find<ScenarioUseCase>()), fenix: true);
  }
}

class ProjectBindings extends Bindings{

  @override
  void dependencies() {

    /// api providers:
    Get.put<ProjectApiProvider>(ProjectApiProvider());

    /// repositories:
    Get.put<ProjectRepository>(ProjectRepositoryImpl(Get.find<ProjectApiProvider>()));

    ///useCase:
    Get.put<ProjectUseCase>(ProjectUseCase(Get.find<ProjectRepository>()));

    /// controllers:
    Get.put(ProjectController(Get.find<ProjectUseCase>()));

  }
}

class HomeBinding extends Bindings{
  @override
  void dependencies() {

    /// api providers:
    Get.put<ProjectBoardApiProvider>(ProjectBoardApiProvider());
    Get.put<HomeApiProvider>(HomeApiProvider());
    Get.put<DeviceApiProvider>(DeviceApiProvider());

    /// repositories:
    Get.put<ProjectBoardRepository>(ProjectBoardRepositoryImpl(Get.find<ProjectBoardApiProvider>()));
    Get.put<HomeRepository>(HomeRepositoryImpl(Get.find<HomeApiProvider>()));
    Get.put<DeviceRepository>(DeviceRepositoryImpl(Get.find<DeviceApiProvider>()));

    ///useCase:
    Get.put<ProjectBoardUseCase>(ProjectBoardUseCase(Get.find<ProjectBoardRepository>()));
    Get.put<RoomUseCase>(RoomUseCase(Get.find<HomeRepository>()));
    Get.put<DeviceUseCae>(DeviceUseCae(Get.find<DeviceRepository>()));

    /// controllers:

    Get.put(RoomController(Get.find<RoomUseCase>()));
    Get.put(DeviceController(Get.find<DeviceUseCae>()));
    Get.lazyPut(() => RelayController(), fenix: true);
    Get.put(DeviceHelperController());
    Get.put(MqttService());
    Get.put(MqttReceiver(Get.find<ProjectBoardUseCase>()));
  }
}

class SettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProjectBoardController(Get.find<ProjectBoardUseCase>()));
  }

}
