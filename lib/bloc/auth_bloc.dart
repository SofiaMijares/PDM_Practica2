// ignore_for_file: override_on_non_overriding_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:musicfindapp/auth/repository_auth.dart';

import 'dart:async';
import 'package:musicfindapp/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository}) :
  _authenticationRepository = authenticationRepository,
  super(const AuthState.unknown())
  {
    on<VerifyAuthStatus>(_verifyAuthStatus);
    on<AuthLogoutRequested>(_logoutRequested);
    on<AuthUser>(_authUser);

  
  }
  final AuthenticationRepository _authenticationRepository;

  // @override
  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is AuthUserChanged) {
  //     yield _mapAuthenticationUserChangedToState(event);
  //   } else if (event is AuthLogoutRequested) {
  //     unawaited(_authenticationRepository.logOut());
  //   }
  // }
  
  // AuthState _mapAuthenticationUserChangedToState(AuthUserChanged event) {
  //   return event.user != User.empty
  //       ? AuthState.authenticated(event.user)
  //       : const AuthState.unauthenticated();
  // }
  
  // @override
  // Future<void> close() {
  //   _userSubscription?.cancel();
  //   return super.close();
  // }
  

  FutureOr<void> _verifyAuthStatus(VerifyAuthStatus event, Emitter<AuthState> emit)async {
    final  user = await _authenticationRepository.getCurrentUser();
    if(user != User.empty){
      emit(AuthState.authenticated(user));
    }else{
      emit(const AuthState.unauthenticated());
    }
  }

  FutureOr<void> _logoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async{
    await _authenticationRepository.logOut();
    emit(const AuthState.unauthenticated());

  }

  FutureOr<void> _authUser(AuthUser event, Emitter<AuthState> emit) async{
    try{
      final user = await _authenticationRepository.logInWithGoogle();
      emit(AuthState.authenticated(user));
      }catch(_){
        emit(const AuthState.unauthenticated());
      }
  }
}
