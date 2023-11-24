import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/resource/app_bindings.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/screen/register.dart';
import 'package:turkeysh_smart_home/test.dart';

import 'core/constants/routes.dart';
import 'core/constants/utils.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings().dependencies();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: GetStorage().read(AppUtils.userTokenAccess) != null
          ? PagesRoutes.project
          : PagesRoutes.login,
      //home: const TestWidget(),
      locale: const Locale('fa'),
      getPages: PagesRoutes.pages,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      theme: ThemeData(
        fontFamily: 'IranSans',
        useMaterial3: true
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Get.find<MqttService>().publishMessage('hello babe');
        }, child: const Text('click'),),
      ),
    );
  }
}

