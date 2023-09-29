
import '../../../../core/resource/data_state.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);


  Future<DataState<String>> registerUserUsecase(String username, String password, String mobileNumber){
    return _repository.registerUser(username, password, mobileNumber);
  }

}