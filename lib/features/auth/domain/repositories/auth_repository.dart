abstract class AuthRepository {
  Future<String?> login({required String email,required String password});
  Future<String?> register({required String email,required String password});
}