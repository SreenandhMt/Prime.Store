import 'package:main_work/features/auth/domain/repositories/auth_repository.dart';

class AuthUsecase {
  AuthRepository _authRepository;
  AuthUsecase(this._authRepository);
  Future<String?> login({required String email,required String password})async{
    return await _authRepository.login(email: email, password: password);
  }
  Future<String?> register({required String email,required String password})async{
    return await _authRepository.register(email: email, password: password);
  }
}