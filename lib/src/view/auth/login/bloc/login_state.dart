part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginMsgState extends LoginState {
  final bool isError;
  final String msg;
  LoginMsgState({required this.isError, required this.msg});
}

final class LoginLoadingState extends LoginState {}
