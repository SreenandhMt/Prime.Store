import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthDataSource {
  Future<String?> login({required String email,required String password})async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
       return e.message;
    }
    return null;
  }
  Future<String?> register({required String email,required String password})async{
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
       return e.code;
    }
    return null;
   
  }
}