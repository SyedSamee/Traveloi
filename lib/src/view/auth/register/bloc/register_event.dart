part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterAUserEvent extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String email;
  final String password;

  RegisterAUserEvent(
      {required this.context,
      required this.fullName,
      required this.email,
      required this.password});
}
