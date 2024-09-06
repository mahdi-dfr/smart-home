class UrlConstant {
  UrlConstant._();

  /// base url:
  // static const String baseUrl = 'http://192.168.252.141:8000/api/';
  // static const String baseUrl = 'https://abzarsanat.runflare.run/api/';
  static const String baseUrl = 'https://iot.perkyiot.com/api/';

  /// websocket
  static const String websocketUrl = 'ws://esp32-server.local:81';


  /// mqtt
  static const String mqttUrl = 'iot.perkyiot.com';
  static const String mqttUsername = 'mosquitto2';
  static const String mqttPassword = 'gjEZPS71fj2WqwinXIpl';

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

  static const String softwareScenario = 'project/software_scenario/';
  static const String softwareScenarioMessage = 'project/software_scenario/get_software_message';
}
