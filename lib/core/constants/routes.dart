import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/app_bindings.dart';
import 'package:turkeysh_smart_home/features/base_page.dart';
import 'package:turkeysh_smart_home/features/home/presentation/screen/view_room.dart';
import 'package:turkeysh_smart_home/features/project/presentation/screen/project_screen.dart';
import '../../features/auth/presentation/screen/login.dart';
import '../../features/auth/presentation/screen/register.dart';
import '../../features/home/presentation/screen/create_room_screen.dart';



class PagesRoutes {
  PagesRoutes._();

  static const String _register = '/register';
  static const String _login = '/';
  static const String _drawer = '/drawer';
  static const String _project = '/project';
  static const String _home = '/home';
  static const String _createRoom = '/create_room';
  static const String _viewRoom = '/view_room';

  static String get login => _login;

  static String get drawer => _drawer;

  static String get project => _project;

  static String get register => _register;

  static String get home => _home;

  static String get viewRoom => _viewRoom;

  static String get createRoom => _createRoom;


  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: register,
      page: () => RegisterScreen(),
    ),

    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),

    GetPage(
      name: project,
      page: () => ProjectScreen(),
      binding: ProjectBindings(),
    ),

    GetPage(
      name: home,
      page: () => const BasePage(),
    ),
    GetPage(
      name: createRoom,
      page: () => const CreateRoomScreen(),
      binding: HomeBindings()
    ),

    // GetPage(
    //     name: viewRoom,
    //     page: () => ViewRoomScreen(),
    // ),

  ];


}
