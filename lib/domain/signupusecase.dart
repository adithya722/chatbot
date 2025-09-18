import 'package:design/repositery/data.dart';



class SignupUseCase {
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  Future<bool> execute(String name, String email, String password) {
    return _authRepository.signup(name, email, password);
  }
}