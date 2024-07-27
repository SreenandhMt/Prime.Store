import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;
  AuthBloc(this._authUsecase) : super(AuthInitial()) {
    on<Login>((event, emit) async{
      try {
      if(event.password.length<=6)
      {
        emit(Error(error: "pass"));
        return;
      }
      emit(Loading());
      final response = await _authUsecase.login(email: event.email, password: event.password);
      if(response!=null)
      {
        emit(Error(error: response));
      }
      emit(AuthInitial());
      }on FirebaseAuthException catch (e) {
        emit(Error(error: e.message!));
      }
    });

    on<SignIn>((event, emit) async{
      try {
        if(event.password.length<=6)
      {
        emit(Error(error: ""));
        return;
      }
      if(event.password!=event.cornformPass)
      {
        emit(Error(error: ""));
        return;
      }
      emit(Loading());
      final response = await _authUsecase.register(email: event.email, password: event.password);
      if(response!=null)
      {
         emit(Error(error: response));
      }
      emit(AuthInitial());
      }on FirebaseAuthException catch (e) {
        emit(Error(error: e.message!));
      }
    });
  }
}
