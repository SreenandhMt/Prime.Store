import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/auth/domain/usecase/auth_usecase.dart';

import '../../../../account/presentaion/bloc/bloc/account_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;
  AuthBloc(this._authUsecase) : super(AuthInitial()) {
    on<Login>((event, emit) async{
      try {
      emit(Loading());
      final response = await _authUsecase.login(email: event.email, password: event.password);
      if(response!=null)
      {
        String message = await errorMessage(response);
        emit(Error(error: message));
      }
      emit(AuthInitial());
      }on FirebaseAuthException catch (e) {
        String message = await signUpErrorMassage(e.code);
        emit(Error(error: message));
      }
    });

    on<SignIn>((event, emit) async{
      try {
      emit(Loading());
      final response = await _authUsecase.register(email: event.email, password: event.password);
      if(response!=null)
      {
        String message = await errorMessage(response);
         emit(Error(error: message));
         return;
      }
      await _firestore.collection("profile").doc(_auth.currentUser!.uid).set(
          {
            "name":event.email.split("@").first,
            "number":"",
            "birthday":"",
            "email":event.email,
            "gender":"",
          }
        );
      emit(AuthInitial());
      }on FirebaseAuthException catch (e) {
        String message = await errorMessage(e.code);
        emit(Error(error: message));
      }
    });
  }

  Future<String> errorMessage(String errorCode)async{
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is not valid.';
        
      case 'wrong-password':
        return 'The password is incorrect.';
        
      case 'user-not-found':
        return 'No user found for that email.';
        
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
        
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
        
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
        
      case 'weak-password':
        return 'The password provided is too weak.';
        
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
        
      case 'network-request-failed':
        return 'A network error occurred.';
        
      case 'requires-recent-login':
        return 'The operation requires recent authentication. Please log in again.';
        
      case 'account-exists-with-different-credential':
        return 'There already exists an account with the email address for the social sign-in.';
        
      case 'credential-already-in-use':
        return 'The credential is already associated with a different user account.';
        
      case 'invalid-credential':
        return 'The credential is not valid or has expired.';
        
      default:
        return 'An unknown error occurred.';
        
    }
  }

  Future<String> signUpErrorMassage(String errorCode)async
  {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
