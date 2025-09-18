import 'package:design/repositery/data.dart';



class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<bool> execute(String email, String password) {
    return _authRepository.login(email, password);
  }
}