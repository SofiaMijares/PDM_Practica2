part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

//Create the auth events
class VerifyAuthStatus extends AuthEvent {}

class AuthUser extends AuthEvent{}

class AuthLogoutRequested extends AuthEvent {}


