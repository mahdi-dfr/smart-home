class UrlConstant {
  UrlConstant._();

  /// base url:
  static const String baseUrl = 'http://192.168.234.141:8000/api/';
  //static const String baseUrl = 'https://abzarsanat.runflare.run/api/';

  /// auth urls:
  static const String register = 'user/auth/register/';
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
}
