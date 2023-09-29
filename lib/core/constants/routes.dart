import 'package:get/get.dart';

import '../../features/auth/presentation/screen/login.dart';
import '../../features/auth/presentation/screen/register.dart';

class PagesRoutes {
  PagesRoutes._();

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: '/',
      page: () => const RegisterScreen(),
    ),
  ];
}
