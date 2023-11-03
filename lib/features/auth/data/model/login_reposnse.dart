
import '../../domain/entity/user_entity.dart';

class LoginResponse extends UserEntity{
  String? refresh;
  String? access;

  LoginResponse({this.refresh, this.access}) : super(refresh: refresh, access: access);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
