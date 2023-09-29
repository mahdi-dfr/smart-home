import '../../../../core/resource/data_state.dart';

abstract class AuthRepository{

  Future<DataState<String>> registerUser(String username, String password, String mobileNumber);

  //Future<DataState<UserEntity>> loginUser(String username, String password);

}