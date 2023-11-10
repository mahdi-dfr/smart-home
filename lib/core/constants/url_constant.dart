class UrlConstant {
  UrlConstant._();

  /// base url:
  static const String baseUrl = 'http://192.168.221.141:8000/api/';

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
}
