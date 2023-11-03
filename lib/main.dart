import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/resource/app_bindings.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/screen/register.dart';

import 'core/constants/routes.dart';
import 'core/constants/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String? userToken = GetStorage().read(AppUtils.userTokenAccess);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: GetStorage().read(AppUtils.userTokenAccess) != null
          ? PagesRoutes.project
          : PagesRoutes.login,
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
