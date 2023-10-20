part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginAUserEvent extends LoginEvent {
  final BuildContext context;

  final String email;
  final String password;

  LoginAUserEvent(
      {required this.context, required this.email, required this.password});
}
