import 'package:dio/dio.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/api_provider.dart';

class AuthRepositoryImpl extends AuthRepository{

  final AuthApiProvider _apiProvider;


  AuthRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<String>> registerUser(String username, String password, String mobileNumber) async {

    try {
      var response = await _apiProvider.registerUser({
        'username': username,
        'password': password,
        'mobile_number': mobileNumber
      });
      if (response is! DioException) {
        if (response.statusCode == 201) {
          return const DataSuccess('success');
        }else{
          return const DataFailed('error');
        }
      }else {
        return DataFailed(response.response.toString());
      }
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  // @override
  // Future<DataState<UserEntity>> loginUser(String username, String password) async {
  //
  //   try {
  //     var response = await _apiProvider.loginUser(username, password);
  //     if (response is! DioException) {
  //       if (response.statusCode == 200) {
  //         UserEntity userEntity = LoginResponse.fromJson(response.data);
  //
  //         return DataSuccess(userEntity);
  //       } else if(response.statusCode == 400) {
  //         return DataFailed('نام کاربری یا رمز عبور اشتباه است');
  //       }else{
  //         return DataFailed(response.statusCode);
  //       }
  //     } else {
  //       return DataFailed(response.response.toString());
  //     }
  //   } catch (e) {
  //     return DataFailed(e.toString());
  //   }
  //
  // }





}