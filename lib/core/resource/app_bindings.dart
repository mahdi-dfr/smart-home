import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/connection_controller.dart';
import 'package:turkeysh_smart_home/features/auth/data/repository/auth_repository_impl.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/controller/register_controller.dart';

import '../../features/auth/data/data_source/api_provider.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecase/auth_usecase.dart';

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
  }

}