import 'package:main_work/features/auth/data/data_sources/remote/auth_data_sources.dart';
import 'package:main_work/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
   final AuthDataSource _authDataSource;
  AuthRepositoryImp(this._authDataSource);
  @override
  Future<String?> login({required String email, required String password}) async{
    return await _authDataSource.login(email: email, password: password);
  }

  @override
  Future<String?> register({required String email, required String password})async {
    return await _authDataSource.register(email: email, password: password);
  }
  
}