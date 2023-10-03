import '../../../../core/resource/data_state.dart';
import '../repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Future<DataState<String>> registerUserUsecase(String username,
      String password, String mobileNumber, String email, String birthDate) {
    return _repository.registerUser(username, password, mobileNumber, email, birthDate);
  }

  Future<DataState<UserEntity>> loginUser(String username, String password){
    return _repository.loginUser(username, password);
  }

}
