import '../../../../core/resource/data_state.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<String>> registerUser(String username, String password,
      String mobileNumber, String email, String birthDate);

  Future<DataState<UserEntity>> loginUser(String username, String password);
}
