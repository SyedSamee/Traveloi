part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterMsgState extends RegisterState {
  final bool isError;
  final String msg;
  RegisterMsgState({required this.isError, required this.msg});
}
