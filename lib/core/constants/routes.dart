import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/app_bindings.dart';
import 'package:turkeysh_smart_home/features/base_page.dart';
import 'package:turkeysh_smart_home/features/device/presentation/screen/create_device.dart';
import 'package:turkeysh_smart_home/features/home/presentation/screen/splash_screen.dart';
import 'package:turkeysh_smart_home/features/project/presentation/screen/project_screen.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/screen/create_hardware_scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/screen/create_software_scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/screen/panel_screen.dart';
import '../../features/auth/presentation/screen/login.dart';
import '../../features/auth/presentation/screen/register.dart';
import '../../features/settings/presentation/screen/board_settings.dart';
import '../../features/home/presentation/screen/create_room_screen.dart';
import '../../features/settings/presentation/screen/create_board.dart';

class PagesRoutes {
  PagesRoutes._();

  static const String _splash = '/splash';
  static const String _register = '/register';
  static const String _login = '/';
  static const String _drawer = '/drawer';
  static const String _project = '/project';
  static const String _home = '/home';
  static const String _createRoom = '/create_room';
  static const String _viewRoom = '/view_room';
  static const String _boardSetting = '/board_Setting';
  static const String _createBoard = '/create_board';
  static const String _createDevice = '/create_device';
  static const String _panelScreen = '/panel_screen';
  static const String _chooseHardwareScenario = '/choose_hardware_scenario';
  static const String _chooseSoftwareScenario = '/choose_software_scenario';


  static String get splash => _splash;

  static String get boardSetting => _boardSetting;

  static String get login => _login;

  static String get drawer => _drawer;

  static String get project => _project;

  static String get register => _register;

  static String get home => _home;

  static String get viewRoom => _viewRoom;

  static String get createRoom => _createRoom;

  static String get createBoard => _createBoard;

  static String get createDevice => _createDevice;

  static String get panelScreen => _panelScreen;

  static String get chooseHardwareScenario => _chooseHardwareScenario;

  static String get chooseSoftwareScenario => _chooseSoftwareScenario;


  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: _splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: _login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _project,
      page: () => ProjectScreen(),
      binding: ProjectBindings(),
    ),
    GetPage(
      name: _home,
      page: () => const BasePage(),
      binding: HomeBinding()
    ),
    GetPage(
      name: _createRoom,
      page: () => const CreateRoomScreen(),
    ),
    GetPage(
        name: _boardSetting,
        page: () => BoardSettingScreen(),
    binding: SettingsBinding()),
    GetPage(
      name: _createBoard,
      page: () => CreateBoardScreen(),
    ),

    GetPage(
      name: _createDevice,
      page: () => CreateDeviceScreen(),
    ),

    GetPage(
      name: _panelScreen,
      page: () => PanelScreen(),
    ),

    GetPage(
      name: _chooseHardwareScenario,
      page: () => ChooseHardwareScenarioScreen(),
    ),

    GetPage(
      name: _chooseSoftwareScenario,
      page: () => ChooseSoftwareScenarioScreen(),
    ),
  ];
}
