class UrlConstant {
  UrlConstant._();

  /// base url:
  static const String baseUrl = 'http://192.168.66.141:8000/api/';
  // static const String baseUrl = 'https://abzarsanat.runflare.run/api/';

  /// auth urls:
  static const String register = 'user/management/';
  static const String login = 'user/auth/token/';
  static const String refresh = 'user/auth/refresh/';

  /// project urls:
  static const String project = 'project/project/';
  static const String projectBoard = 'project/project_board/';
  static const String controlBoards = 'project/control_boards/';

  /// home:
  static const String room = 'project/room/';

  /// device:
  static const String deviceNode = 'project/device_nodes/';
  static const String device = 'project/device/';
  static const String nodeProject = 'project/node_project/';

  /// scenario
  static const String hardwareScenario = 'project/hardware_scenario/';
  static const String hardwareScenarioMessage = 'project/hardware_scenario/get_scenario_message';
}
